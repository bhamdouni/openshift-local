# Virtual Network
resource "azurerm_virtual_network" "crcnetwork" {
    name                  = "${var.computer_name}_Vnet"
    address_space         = ["10.0.0.0/16"]
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
}

# SubNet
resource "azurerm_subnet" "crcsubnet" {
    name                  = "${var.computer_name}_Subnet"
    address_prefixes      = ["10.0.1.0/24"]
    resource_group_name   = azurerm_resource_group.rg.name
    virtual_network_name  = azurerm_virtual_network.crcnetwork.name
}

# Public IP
resource "azurerm_public_ip" "crcpublicip" {
    name                    = "${var.computer_name}_PublicIP"
    location              = azurerm_resource_group.rg.location
    resource_group_name     = azurerm_resource_group.rg.name
    allocation_method       = "Dynamic"
}

# azurerm_network_interface.crcnic will be created
resource "azurerm_network_interface" "crcnic" {
    name                          = "${var.computer_name}_NIC"
    location                      = azurerm_resource_group.rg.location
    resource_group_name           = azurerm_resource_group.rg.name

    ip_configuration {
        name                                               = "${var.computer_name}_NicConfiguration"
        subnet_id                                          = azurerm_subnet.crcsubnet.id
        private_ip_address_allocation                      = "Dynamic"
        public_ip_address_id                               = azurerm_public_ip.crcpublicip.id
    }
}
