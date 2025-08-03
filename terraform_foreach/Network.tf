resource "azurerm_public_ip" "PUBIP" {
  for_each            = var.VMs
  name                = "mypubip-${each.value.name}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
  sku                 = "Basic"

}

resource "azurerm_virtual_network" "Vnet1" {
  name                = "MyVnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = [each.value]
}

resource "azurerm_network_interface" "myvmnic" {
  for_each            = var.VMs
  name                = each.value.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal-${var.prefixes}-${each.value.name}"
    subnet_id                     = azurerm_subnet.subnets[each.value.subnet_name].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PUBIP[each.key].id
  }
}