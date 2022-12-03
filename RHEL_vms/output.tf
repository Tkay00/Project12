output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

output "nsg_id" {
  value = azurerm_network_security_group.vm-nsg.id
  description = "The id of network security group"
}