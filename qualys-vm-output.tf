###############################
## Qualys Appliance - Output ##
###############################

output "qualys_vm_name" {
  description = "Qualys Virtual Machine name"
  value       = azurerm_linux_virtual_machine.qualys-vm.name
}

output "qualys_vm_ip_address" {
  description = "Qualys Virtual Machine IP Address"
  value       = azurerm_linux_virtual_machine.qualys-vm.private_ip_address
}

output "qualys_vm_admin_username" {
  description = "Username password for the Virtual Machine"
  value       = var.qualys_admin_username
}

