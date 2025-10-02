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



/*variable "subnets" {
  description = "Map of subnet names to their address prefixes"
  type        = map(string)
  default = {
    subnet1 = string
    subnet2 = string

  }
}*/

variable "subnets" {
  type = map(string)
 
}
variable "prefixes" {
  type        = string
  description = "Prefix for naming all Azure resources"

}