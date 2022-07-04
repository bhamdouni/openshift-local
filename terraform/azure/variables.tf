# Change your resource group prefix name if desired
variable "resource_group_name_prefix" {
  default       = "crc"
  description   = "Prefix of the resource group name, to combien with a random ID for unicity"
}

# Change your VM name if desired
variable "computer_name" {
    default     = "crc"
    description = "VM computer name"
}

# Change your resource group location if desired
variable "resource_group_location" {
  default       = "francecentral"
  description   = "Location of the resource group."
}

# Minimum VM Size requested par OpenShift Cluster Local
variable "vm_size" {
  default       = "Standard_D4s_v3"
  description   = "VM Size"
}

# Put your chosen admin name here
variable "admin_username" {
  default       = <admin-username>
  description   = "OS username to use"
}


# Put your chosen SSH public key here
variable "ssh_public_key" {
    default = <ssh-public-key>
    description = "admin Openssh public key"
}
