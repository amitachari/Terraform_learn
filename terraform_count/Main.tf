
resource "azurerm_resource_group" "myRG" {
  name     = "Terraform_RG"
  location = "East US"

}
<<<<<<< HEAD
resource "random_string" "storage_account_name_unique" {
  {
  length  = 16
  special = false
  upper   = false
  count   = 2
}

resource "azurerm_storage_account" "mystoragebox" {
  count                    = 1
  name                     = "mybox${random_string.storage_account_name_unique[count.index].result}"
  resource_group_name      = azurerm_resource_group.myRG.name
  location                 = azurerm_resource_group.myRG.location
  account_tier             = "Standard"
  account_replication_type = "GRS"



} 

 /*resource "azurerm_storage_account" "mystoragebox" {
  count                    = 2
  name                     = "mybox${count.index + 1}"
  resource_group_name      = azurerm_resource_group.myRG.name
  location                 = azurerm_resource_group.myRG.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}*/
