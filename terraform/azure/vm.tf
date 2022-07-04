# azurerm_linux_virtual_machine.crcvm will be created      
resource "azurerm_linux_virtual_machine" "crcvm" {       
    name                            = var.computer_name
    location                        = azurerm_resource_group.rg.location    
    resource_group_name             = azurerm_resource_group.rg.name        
    network_interface_ids           = [azurerm_network_interface.crcnic.id]
    size                            = "Standard_D4s_v3"  

    os_disk {
        name                      = "${var.computer_name}_OsDisk"
        caching                   = "ReadWrite"
        storage_account_type      = "StandardSSD_LRS"
        disk_size_gb              = 64
    }

    source_image_reference {
        offer     = "RHEL"
        publisher = "RedHat"
        sku       = "82gen2"
        version   = "latest"
    }

    computer_name                   = var.computer_name
    admin_username                  = var.admin_username       
    disable_password_authentication = true

    admin_ssh_key {
        public_key = var.ssh_public_key
        username   = var.admin_username
    }
}
