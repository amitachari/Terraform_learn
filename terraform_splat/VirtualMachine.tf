

resource "azurerm_windows_virtual_machine" "demovm" {
  count                 = 2
  name                  = "app-vm-${count.index}"
  resource_group_name   = azurerm_resource_group.RG10.name
  location              = azurerm_resource_group.RG10.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  admin_password        = "P@$$w0rd1234!"
  network_interface_ids = [element(azurerm_network_interface.myvmnic[*].id, count.index)]

  os_disk {
    name                 = "os_disk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}