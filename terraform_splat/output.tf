output "vmname" {
    value = [for vm in azurerm_windows_virtual_machine.demovm : vm.name]
  
}
output "vm_public_ip" {
  
  value = [for ip in azurerm_public_ip.PUBIP : ip.ip_address]
}