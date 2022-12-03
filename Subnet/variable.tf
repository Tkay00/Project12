variable "subnets" {
  type = map(any)
  description = "The name and address prefixes for the network subnet"
}

variable "vnet_name" {
  type = string
  description = "The name of the network VNET"
}


# variable "sql_subnet" {
#   type = string
#   description = "The name for the network subnet"
# }

# variable "vm_resource_group" {
#   type        = string
#   description = "The resource group in which the vms would be created"
# }

# variable "sql_resource_group" {
#   type        = string
#   description = "The resource group in which the database would be created"
# } 

# variable "vmsubnet_address_prefixes" {
#   type        = list(any)
#   description = "The address space for the vnet"
# }

# variable "sqlsubnet_address_prefixes" {
#   type        = list(any)
#   description = "The address space for the vnet"
# }

