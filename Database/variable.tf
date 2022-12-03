variable "mssqlserver-primary" {
  type = string
  description = "The primary mssql server"
}

variable "mssqlserver-secondary" {
  type = string
  description = "The secondary mssql server"
}

variable "sql_resource_group" {
  type        = string
  description = "The resource group in which the database will be created"
} 

variable "version" {
  type        = numeric
  description = "The region for the deployment"
}

variable "location" {
  type        = string
  description = "The region for the deployment"
}

variable "wmdatabse0" {
  type = string
  description = "The database for mssql server"
}

variable "wmdatabse1" {
  type = string
  description = "The database for mssql server"
}

variable "wmdatabse2" {
  type = string
  description = "The database for mssql server"
}

variable "tags" {
  type = string
  description = "The secondary mssql server"
}

variable "admin_username" {
  type        = string
  description = "The admin username for the databases"
}

variable "random_password_length" {
  description = "The desired length of random password created by this module"
}

variable "public_ip_allocation_method" {
  type = string
  description = "(optional) describe your variable"
}

variable "public_ip_sku" {
  type = string
  description = "The SKU that should be used for the Public IP"
}

variable "public_ip_sku_tier" {
  description = "The SKU Tier that should be used for the Public IP. Possible values are `Regional` and `Global`"
}

variable "lb_sku" {
  type = string
  description = "The SKU that should be used for the Public IP"
}

variable "application_port" {
  type = string 
}

variable "protocol" {
  type = string 
}

variable "var.frontend_port" {
  type = string 
  default = "3389"
}

variable "var.backend_port" {
  type = string 
  default = "3389"
}

variable "sql_subnet_nsg" {
  type        = list(any)
  description = "The address space for the vnet"
}