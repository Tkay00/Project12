
output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
    description = "ID of the vnet"
}

output "subnet_id" {
  value = azurerm_subnet.vm-subnet.id
  description = "The id of subnet created in the new vNet"
}

output "sql_database_id" {
  value = [ 
    azurerm_mssql_database.database0.id,
    azurerm_mssql_database.database1.id,
    azurerm_mssql_database.database2.id
  ]
}

output "nsg_id" {
  value = azurerm_network_security_group.vm-nsg.id
  description = "The id of network security group"
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

output "nsg_id" {
  value = azurerm_network_security_group.vm-nsg.id
  description = "The id of network security group"
}

output "random_password" {
    value = random_password.linux-vm-password.result
    sensitive = true
}

output "random_password" {
    value = random_password.sql-database-password.result
    sensitive = true
}
