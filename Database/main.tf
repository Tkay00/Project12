resource "random_password" "sql-database-password" {
  length           = var.random_password_length
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric           = true
  special          = true
  override_special = "!@#$%&"
}

data "azurerm_subnet" "sql-subnet" {
  name                 = var.sql_subnet
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.sql_resource_group                        #data.azurerm_resource_group.rg.name
}

resource "azurerm_mssql_server" "primary" {
  name                         = var.mssqlserver-primary
  location                     = var.location
  resource_group_name          = var.sql_resource_group
  version                      = var.version 
  administrator_login          = var.admin_username
  administrator_login_password = random_password.sql-database-password.result
}

resource "azurerm_mssql_server" "secondary" {
  name                         = var.mssqlserver-secondary
  location                     = var.location
  resource_group_name          = var.sql_resource_group
  version                      = var.version 
  administrator_login          = var.admin_username
  administrator_login_password = random_password.sql-database-password.result
}

resource "azurerm_mssql_database" "database0" {
  name        = var.wmdatabse0
  server_id   = azurerm_mssql_server.primary.id
  sku_name    = "S1"
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = "500"
}

resource "azurerm_mssql_database" "database1" {
  name        = var.wmdatabse1
  server_id   = azurerm_mssql_server.primary.id
  sku_name    = "S1"
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = "500"
}

resource "azurerm_mssql_database" "database2" {
  name        = var.wmdatabse2
  server_id   = azurerm_mssql_server.primary.id
  sku_name    = "S1"
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = "500"
}

resource "azurerm_mssql_failover_group" "failover-group" {
  name      = "failover group"
  server_id = azurerm_mssql_server.primary.id
  databases = [
    azurerm_mssql_database.database0.id,
    azurerm_mssql_database.database1.id,
    azurerm_mssql_database.database2.id
  ]

  partner_server {
    id = azurerm_mssql_server.secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 80
  }

  tags = var.tags
}


resource "azurerm_public_ip" "publicip" {
  name                = lower("${var.sql_resource_group}lb")
  location            = var.location
  resource_group_name = var.sql_resource_group
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  sku_tier            = var.public_ip_sku_tier
}

resource "azurerm_lb" "lb" {
  name                = "${var.sql_resource_group}-lb"
  location            = var.location
  resource_group_name = var.sql_resource_group
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.publicip.id   
  }
}

resource "azurerm_lb_probe" "lb_probe" {
  name            = "${var.sql_resource_group}-lb_probe"
  loadbalancer_id = azurerm_lb.lb.id
  port            = var.application_port
  protocol        = var.protocol
}

resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_rule" "example" {
  resource_group_name            = var.sql_resource_group
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "RDPAccess"
  protocol                       = var.protocol
  frontend_port                  = var.frontend_port 
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_subnet_network_security_group_association" "vm-nsg-association" {
  subnet_id                 = data.azurerm_subnet.sql-subnet.id
  network_security_group_id = azurerm_network_security_group.sql-nsg.id
}

resource "azurerm_network_security_group" "sql-nsg" {
  name                = lower("${var.sql_subnet_nsg}-nsg")
  location            = var.location
  resource_group_name = var.sql_resource_group

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "vm-nsg-association" {
  subnet_id                 = data.azurerm_subnet.sql-subnet.id
  network_security_group_id = azurerm_network_security_group.sql-nsg.id
}
