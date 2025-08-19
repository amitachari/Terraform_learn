
resource "azurerm_virtual_network" "Vnet" {
  name                = "MyVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.MYRG.location
  resource_group_name = azurerm_resource_group.MYRG.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.MYRG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "NSG" {
  name                = "mynsg"
  resource_group_name = azurerm_resource_group.MYRG.name
  location            = azurerm_resource_group.MYRG.location
  depends_on = [ 
    azurerm_virtual_network.Vnet,
    azurerm_subnet.subnet,
    azurerm_storage_account.storage ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_link" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.NSG.id

}
resource "azurerm_network_interface" "NIC" {
  name                = "vm-nic"
  location            = azurerm_resource_group.MYRG.location
  resource_group_name = azurerm_resource_group.MYRG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "VM" {
  name                = "my-app-vm"
  resource_group_name = azurerm_resource_group.MYRG.name
  location            = azurerm_resource_group.MYRG.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

  os_disk {
    name                 = "os_disk"               
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage.primary_blob_endpoint
  }

  depends_on = [
    azurerm_storage_account.storage
  ]
}



resource "azurerm_storage_account" "storage" {
  name                     = "terraformcodestorage"
  location                 = azurerm_resource_group.MYRG.location
  resource_group_name      = azurerm_resource_group.MYRG.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

}