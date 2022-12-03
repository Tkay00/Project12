resource "azurerm_subnet" "vm-subnet" {
  for_each             = var.subnets
  name                 = each.value["name"]
  resource_group_name  = each.value["resource_group"]
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value["address_prefixes"]
}

# resource "azurerm_subnet" "vm-subnet" {
#   name                 = var.vm_subnet
#   resource_group_name  = var.vm_resource_group
#   virtual_network_name = var.vnet_name.name
#   address_prefixes     = var.vmsubnet_address_prefixes
# }

# resource "azurerm_subnet" "sql-subnet" {
#   name                 = var.sql_subnet
#   resource_group_name  = var.sql_resource_group
#   virtual_network_name = var.vnet_name.name
#   address_prefixes     = var.sqlsubnet_address_prefixes
# }