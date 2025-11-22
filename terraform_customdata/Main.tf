resource "azurerm_windows_virtual_machine" "VirtualMachine" {
  name                = "customdata-VM"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.Interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
<<<<<<< HEAD

}

resource "azurerm_virtual_machine_extension" "adds_install" {
  name                 = "ADDSInstall"
  virtual_machine_id   = azurerm_windows_virtual_machine.VirtualMachine.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
=======
  
}

resource "azurerm_virtual_machine_extension" "adds_install" {
  name = "ADDSInstall"
  virtual_machine_id = azurerm_windows_virtual_machine.VirtualMachine.id
  publisher = "Microsoft.Compute"
  type = "CustomScriptExtension"
>>>>>>> b4b0ecf2bf10d309dd57d613817b325a0036c4e7
  type_handler_version = "1.10"

  settings = <<SETTINGS
  {
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -command \"$(Get-Content ${path.module}/ADDSInstall.ps1 | Out-String)\""
  }
 SETTINGS
}