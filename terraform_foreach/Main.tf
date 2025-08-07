

resource "azurerm_windows_virtual_machine" "demovm" {
  for_each              = var.VMs
  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = each.value.vm_size
  admin_username        = each.value.user_name
  admin_password        = "P@$$w0rd1234!"
  network_interface_ids = [azurerm_network_interface.myvmnic[each.key].id]

  os_disk {
    name                 = "os_disk-${each.value.name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  #lifecycle changes
  
}