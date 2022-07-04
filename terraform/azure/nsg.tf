# Network Security Group
resource "azurerm_network_security_group" "crcnsg" {
    name                = "${var.computer_name}_NSG"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    security_rule {
        name                                       = "SSH"
        priority                                   = 1001
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        destination_address_prefix                 = "*"
        destination_port_range                     = "22"
        source_address_prefix                      = "*"
        source_port_range                          = "*"
    }

    security_rule {
        name                                       = "HTTP"
        priority                                   = 1002
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        destination_address_prefix                 = "*"
        destination_port_range                     = "80"
        source_address_prefix                      = "*"
        source_port_range                          = "*"
    }
    security_rule {
        name                                       = "HTTPS"
        priority                                   = 1003
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        destination_address_prefix                 = "*"
        destination_port_range                     = "443"
        source_address_prefix                      = "*"
        source_port_range                          = "*"
    }
    security_rule {
        name                                       = "API"
        priority                                   = 1004
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        destination_address_prefix                 = "*"
        destination_port_range                     = "6443"
        source_address_prefix                      = "*"
        source_port_range                          = "*"
    }
}


# Connect Network Security Group to Network Interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.crcnic.id
    network_security_group_id = azurerm_network_security_group.crcnsg.id
}