resource "azurerm_public_ip" "PUBIP" {
  count               = 2
  name                = "mypubip-${count.index + 1}"
  resource_group_name = azurerm_resource_group.RG10.name
  location            = azurerm_resource_group.RG10.location
  allocation_method   = "Static"
  domain_name_label   = "appvm-${count.index}"
  sku                 = "Basic"

}

resource "azurerm_virtual_network" "Vnet1" {
  name                = "MyVnet"
  location            = azurerm_resource_group.RG10.location
  resource_group_name = azurerm_resource_group.RG10.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnets" {
  count = 2
  name                 = "subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.RG10.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = [var.subnet_cidrs[count.index]]
}

resource "azurerm_network_interface" "myvmnic" {
  count               = 2
  name                = "vmnic-${count.index}"
  location            = azurerm_resource_group.RG10.location
  resource_group_name = azurerm_resource_group.RG10.name
  ip_configuration {
    name                          = "internal-${count.index}"
    subnet_id                     = element(azurerm_subnet.subnets[*].id, count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.PUBIP[*].id, count.index)
  }
}