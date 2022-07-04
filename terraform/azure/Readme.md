# Scope
Create an OpenShift Cluster Local in RedHat Linux VM hosted by Azure

# Prerequesties
- an azure account and (Optionnal) a configured service principal with Contributor role attributed
- a Red Hat account
- (Optional) a preconfigured SSH key
- write acces to your local */etc/hosts* (Linux) file or *%Windir%System32\drivers\etc\hosts* (Windows)
- download pull secret from [Red Hat OpenShift Local page on the Red Hat Hybrid Cloud Console.](https://console.redhat.com/openshift/create/local)

# Installation
- Fill *providers.tf* with your azure credentials and subscriptions infos
- Fill *variables.tf* with your chosen *admin_username* and you SSH public key
- Go terraform !
```
terraform init
terraform plan -out main.tfplan
terraform apply main.tfplan
```
- you need to refresh terraform state to get public ip address (because we are usong a Dynamic one, that need VM attachment first)
```
terraform refresh
```
- add an entry in your */etc/hosts* (Linux) file or *%Windir%System32\drivers\etc\hosts* (Windows)
```
<public_ip_address> api.crc.testing apps-crc.testing console-openshift-console.apps-crc.testing oauth-openshift.apps-crc.testing
```
- SSH to your newly created VM `Host: api.crc.testing, Username: *admin_username*`. And copy *crc-install.sh* file, and fill a *pull-secret.txt* file with content fetched previously from Red Hat console. 
- install openshift cluster local
```
./crc-install.sh
```
- keep url and connection credentials (output of last 2 lines)
```
crc console --credentials
crc console --url
```

# For further reading
[Red Hat OpenShift Local documentation](https://access.redhat.com/documentation/en-us/red_hat_openshift_local)