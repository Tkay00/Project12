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