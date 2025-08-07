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
    vm_size     = "Standard_B2s"
    user_name   = "vmadmin2"
    subnet_name = "subnet2"

  }

}

subnets = {
subnet1 = "10.0.1.0/24"
subnet2 = "10.0.2.0/24"
}