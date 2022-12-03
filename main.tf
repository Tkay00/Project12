terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.32.0"
    }
  }
}

provider "azurerm" {
  features { }
}

resource "azurerm_resource_group" "vm-rg" {
  name     = var.vm_resource_group
  location = var.location
  tags     = "${merge(var.tags,{type = "RG"})}"
}

resource "azurerm_resource_group" "sql-rg" {
  name     = var.sql_resource_group
  location = var.location
  tags     = "${merge(var.tags,{type = "RG"})}"
}

module "Vnet" {
    source              = "./modules/Vnet"
    resource_group_name = azurerm_resource_group.vm-rg.name
    location            = var.location
    tags                = "${merge(var.tags,{type = "network"})}"
    vnet_name           = var.vnet_name
    address_space       = var.address_space
}

module "Subnet" {
    for_each            = var.subnets
    source              = "./modules/Subnet"
    resource_group_name = each.value["resource_group"]
    vnet_name           = var.vnet_name      #"${azurerm_resource_group.vm-rg.name}-vnet"
    subnet_name         = each.value["name"]
    address_prefixes    = each.value["address_prefixes"]
}

module "RHEL_VM" {
  source              = "./modules/RHEL_vms"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = var.location
  tags                = "${merge(var.tags, {type = "resource"})}"
  vmss_name           = "${var.vm_resource_group}-lb"
  vmss_lb_name        = "${azurerm_resource_group.vm-rg.name}-lb"
  publicip            = lower("${length(var.rhel_vms)}nic${count.index}")    #"${azurerm_resource_group.resource_group.name}-publicip"
  subnet_id           = module.application-subnet.vnet_subnet_id
  admin_username      = var.admin_username
  admin_password      = random_password.linux-vm-password.result

}

module "Database" {
    source              = "./modules/Database"
    resource_group_name = azurerm_resource_group.sql-rg.name
    administrator_login          = var.admin_username
   administrator_login_password = random_password.sql-database-password.result
}