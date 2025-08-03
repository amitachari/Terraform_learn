/*resource "azurerm_resource_group" "RG15" {
  for_each = {
    dallasRG = "East US"
    TexasRG  = "West US"

  }

  name     = each.key
  location = each.value
}*/