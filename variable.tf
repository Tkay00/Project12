variable "vm_resource_group" {
  type        = string
  description = "The resource group in which the vms would be created"
  default     = "wmbqutarmrgp003"
}

variable "sql_resource_group" {
  type        = string
  description = "The resource group in which the databases would be created"
  default     = "wmbqutarmrgp004"
}


variable "location" {
  type        = string
  description = "The region for the deployment"
  default     = "Central US"
}

variable "vnet_name" {
  type = string
  description = "The name of the network VNET"
  default = "wmbqutarmrgp-vnet"
}

variable "address_space" {
  type        = list(any)
  description = "The address space for the vnet"
  default = ["10.2.0.0/16"]
}

variable "subnets" {
  type = map(any)
  description = "The name and address prefixes for the network subnet"
  default = {
    subnet_1 = {
      name             = "wmbqutarmrgp003-subnet"
      address_prefixes = ["10.2.1.0/24"]
      resource_group   = "wmbqutarmrgp003"
    }
    subnet_2 = {
      name             = "wmbqutarmrgp004-subnet"
      address_prefixes = ["10.2.2.0/24"]
      resource_group   = "wmbqutarmrgp004"
    }
  }
}

variable "random_password_length" {
  description = "The desired length of random password created by this module"
  default     = 24
}

variable "public_ip_allocation_method" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Static"
}

variable "public_ip_sku" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Standard"
}

variable "public_ip_sku_tier" {
  description = "The SKU Tier that should be used for the Public IP. Possible values are `Regional` and `Global`"
  default     = "Regional"
}

variable "lb_sku" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Standard"
}

variable "vm_subnet_nsg" {
  type        = list(any)
  description = "The address space for the vnet"
}

variable "application_port" {
  type    = string
  default = "22"
}

variable "protocol" {
  type    = string
  default = "Tcp"
}

variable "var.frontend_port" {
  type = string 
  default = "3389"
}

variable "var.backend_port" {
  type = string 
  default = "3389"
}

variable "private_ip_address_allocation_type" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  default     = "Dynamic"
}

variable "instances_count" {
  description = "The number of Virtual Machines required."
  default     = 4
}

variable "instances_count" {
  description = "The number of Virtual Machines required."
  default     = 5
}

variable "virtual_machine_name" {
  description = "The name of the virtual machine."
  default     = ""
}

variable "rhel_vms" {
  type        = map(any)
  description = "Specifies the name, size and sku for each virtual machine."
  default = {
    VM1 = {
      name         = "VM1-a"
      size         = "Standard_E16a_v4"
      disk_size_gb = null
      os_disk_name = null
    }
    VM2 = {
      name         = "VM1-b"
      size         = "Standard_E16a_v4"
      disk_size_gb = null
      os_disk_name = null
    }
    VM3 = {
      name         = "VM2-a"
      size         = "Standard_E8as_v4"
      disk_size_gb = null
      os_disk_name = null
    }
    VM4 = {
      name         = "VM2-b"
      size         = "Standard_E8as_v4"
      disk_size_gb = null
      os_disk_name = null
    }
    VM5 = {
      name         = "VM3-a"
      size         = "Standard_D2as_v4"
      disk_size_gb = null
      os_disk_name = null
    }
    VM6 = {
      name         = "VM3-b"
      size         = "Standard_D2as_v4"
      disk_size_gb = null
      os_disk_name = null
    }
  }
}

variable "linux_distribution_name" {
  default     = "rhel85"
  description = "Variable to pick an OS flavour for Linux based VM. Possible values include: centos8, ubuntu1804, rhel85"
}

variable "linux_distribution_list" {
  description = "Pre-defined Azure Linux VM names"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default = {
    "rhel85" = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "85-gen2"
      version   = "latest"
    }
  }
}

variable "admin_username" {
  description = "administrator user name"
  type        = string
  default     = "vmadmin"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
  default     = []
}

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS."
  default     = "StandardSSD_LRS"
}

variable "os_disk_name" {
  description = "The name which should be used for the Internal OS Disk"
  default     = null
}

variable "mssqlserver-primary" {
  type = string
  description = "The primary mssql server"
  default = "wmbqutarmrgp004-pry"
}

variable "mssqlserver-secondary" {
  type = string
  description = "The secondary mssql server"
  default = "wmbqutarmrgp004-sec"
}

variable "wmdatabse0" {
  type = string
  description = "The database for mssql server"
  default = "wmbqutarmrgp004-db0"
}

variable "wmdatabse1" {
  type = string
  description = "The database for mssql server"
  default = "wmbqutarmrgp004-db1"
}

variable "wmdatabse2" {
  type = string
  description = "The database for mssql server"
  default = "wmbqutarmrgp004-db2"
}

variable "version" {
  type        = numeric
  description = "The region for the deployment"
  default = "12.0"
}

variable "tags" {
  type        = map(any)
  description = "The tags for the resources"
  default = {
     environment = "Dev"
     deployed_by = "terraform" 
  }
}

