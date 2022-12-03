variable "vnet_name" {
  type = string
  description = "The name of the network VNET"
}

variable "vm_resource_group" {
  type        = string
  description = "The resource group in which the vms would be created"
}  

variable "location" {
  type        = string
  description = "The region for the deployment"
}

variable "address_space" {
  type        = list(any)
  description = "The address space for the vnet"
}

variable "var.tags" {
  type        = string
  description = "Virtual machine source image publisher"
}