output "vm_name" {
  value = [for vm in azurerm_windows_virtual_machine.demovm : vm.name ]
}

output "public_ip" {
  value = [for ip in azurerm_public_ip.PUBIP : ip.ip_address]
}

/* output "output_table" {
    value = [
     for i in range(length(azurerm_windows_virtual_machine.demovm)) : "${azurerm_windows_virtual_machine.demovm[i].name} => ${azurerm_public_ip.PUBIP[i].ip_address}"

 ]
  
}*/