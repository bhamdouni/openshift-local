#!/bin/sh

# optionnel : installer tmux
sudo yum install -y tmux
	
# installer quelques packages supp et agrandir la taille du lv home à 35 G mini:
sudo yum install -y NetworkManager 
sudo lvresize --size 40G -r rootvg/homelv -v

# Télécharge/Installer/démarrer CRC :
wget https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
mkdir -p ~/bin
tar -xvf crc-linux-amd64.tar.xz --strip-components=1 -C ~/bin/ crc-linux-2.5.1-amd64/crc
crc config set consent-telemetry no
# Optional cluster-monitoring
crc config set enable-cluster-monitoring true
crc config set memory 14336
#
crc setup 
crc start -p ~/pull-secret.txt

# Configurer pour un accès distant (un doute sur l'utilité de firewalld et semanage)
sudo dnf install -y haproxy /usr/sbin/semanage
sudo systemctl enable --now firewalld
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --add-service=kube-apiserver --permanent
sudo firewall-cmd --reload
sudo semanage port -a -t http_port_t -p tcp 6443
sudo cp /etc/haproxy/haproxy.cfg{,.bak}

export CRC_IP=$(crc ip)
sudo tee /etc/haproxy/haproxy.cfg &>/dev/null <<EOF
global
    log /dev/log local0

defaults
    balance roundrobin
    log global
    maxconn 100
    mode tcp
    timeout connect 5s
    timeout client 500s
    timeout server 500s

listen apps
    bind 0.0.0.0:80
    server crcvm $CRC_IP:80 check

listen apps_ssl
    bind 0.0.0.0:443
    server crcvm $CRC_IP:443 check

listen api
    bind 0.0.0.0:6443
    server crcvm $CRC_IP:6443 check
EOF

sudo systemctl start haproxy
