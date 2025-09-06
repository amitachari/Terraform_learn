
resource "azurerm_resource_group" "myRG" {
  name     = "Terraform_RG1"
  location = "East US"

}
resource "random_string" "storage_account_name_unique" {
  length  = 8
  special = false
  upper   = false
  count   = 2
}

resource "azurerm_storage_account" "mystoragebox" {
  count                    = 4
  name                     = "mybox${random_string.storage_account_name_unique[count.index].result}"
  resource_group_name      = azurerm_resource_group.myRG.name
  location                 = azurerm_resource_group.myRG.location
  account_tier             = "Standard"
  account_replication_type = "GRS"



}

