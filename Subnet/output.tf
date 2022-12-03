output "subnet_id" {
  value = azurerm_subnet.vm-subnet.id
  description = "The id of subnet created in the new vNet"
}

