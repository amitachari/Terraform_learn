variable "VMs" { #VM configuration
  type = map(object({
    name        = string
    vm_size     = string
    user_name   = string
    subnet_name = string


  }))

}



variable "resource_group_name" {
  type        = string
  description = "ResourceGroup Name"
  # default = "TFRG-0"
}

variable "resource_group_location" {
  type        = string
  description = "ResourceGroup location"
  # default = "TFRG-0"
}



variable "subnets" {
  description = "Map of subnet names to their address prefixes"
  type        = map(string)
  default = {
    subnet1 = "10.0.1.0/24"
    subnet2 = "10.0.2.0/24"

  }
}

variable "prefixes" {
  type        = string
  description = "Prefix for naming all Azure resources"

}