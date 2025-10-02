resource_group_name     = "TFRG-0"
prefixes                = "Devservers"
resource_group_location = "East US"


VMs = {
  vm1 = {
    name        = "IISserver"
    vm_size     = "Standard_B1s"
    user_name   = "vmadmin1"
    subnet_name = "subnet1"

  },
  vm2 = {
    name        = "DBserver"
    vm_size     = "Standard_B1s"
    user_name   = "vmadmin2"
    subnet_name = "subnet2"

  }

}
