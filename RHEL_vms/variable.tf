
variable "vm_resource_group" {
  type        = string
  description = "The resource group in which the vms would be created"
  default = "wmbqutarmrgp003"
}

variable "location" {
  type        = string
  description = "The region for the deployment"
  default = "US Central"
}

variable "vm_subnet" {
  type = string
  description = "The name for the network subnet"
}

variable "random_password_length" {
  description = "The desired length of random password created by this module"
  default     = 24
}

variable "public_ip_allocation_method" {
  type = string
  description = "(optional) describe your variable"
  default = "Static"
}

variable "public_ip_sku" {
  type = string
  description = "(optional) describe your variable"
  default = "Standard"
}

variable "public_ip_sku_tier" {
  description = "The SKU Tier that should be used for the Public IP. Possible values are `Regional` and `Global`"
  default     = "Regional"
}

variable "lb_sku" {
  type = string
  description = "(optional) describe your variable"
  default = "Standard"
}

variable "application_port" {
  type = string 
  default = "22"
}

variable "protocol" {
  type = string 
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

variable "rhel85" {
  type = map(any)
  description = "Specifies the name, size and sku for each virtual machine."
  default     = {
    VM1 = {
      name = "VM1-a"
      size = "Standard_E16ds_v5"
      disk_size_gb = "128"
    }
    VM2 = {
      name = "VM1-b"
      size = "Standard_E16ds_v5"
      disk_size_gb = "128"
    }
    VM3 = {
      name = "VM2-a"
      size = "Standard_E8ds_v5"
      disk_size_gb = "64"
    }
    VM4 = {
      name = "VM2-b"
      size = "Standard_E8ds_v5"
      disk_size_gb = "64"
    }
    VM5 = {
      name = "VM3-a"
      size = "Standard_FX12mds"
      disk_size_gb = "252"
    }
    VM6 = {
      name = "VM3-b"
      size = "Standard_FX12mds"
      disk_size_gb = "252"
    }
  }
}

variable "instances_count" {
  description = "The number of Virtual Machines required."
  default     = 4
}

variable "instances_count2" {
  description = "The number of Virtual Machines required."
  default     = 5
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
}

# variable "image_publisher" {
#   type        = string
#   description = "Virtual machine source image publisher"
#   default     = "RedHat"
# }

# variable "image_offer" {
#   type        = string
#   description = "Virtual machine source image offer"
#   default     = "RHEL"
# }

# variable "image_sku" {
#   type        = string
#   description = "SKU for RHEL 8.5"
#   default     = "8_5"
# }

# variable "image_version" {
#   description = "version of the image to apply (az vm image list)"
#   default     = "latest"
# }

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS."
  default     = "StandardSSD_LRS"
}

# variable "os_disk_size_gb" {
#   description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
#   default     = 128
# }

variable "os_disk_name" {
  description = "The name which should be used for the Internal OS Disk"
  default     = null
}

variable "admin_username" {
  description = "administrator user name"
  default     = "vmadmin"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
}

# variable "vm_subnet_nsg" {
#   type        = list(any)
#   description = "The address space for the vnet"
# }

























# variable "rhel_7_8_sku" {
#   type        = string
#   description = "SKU for RHEL 7.8"
#   default     = "7.8"
# }

# variable "rhel_7_8_gen2_sku" {
#   type        = string
#   description = "SKU for RHEL 7.8 Gen2"
#   default     = "78-gen2"
# }

# variable "rhel_7_9_sku" {
#   type        = string
#   description = "SKU for RHEL 7.9"
#   default     = "7_9"
# }

# variable "rhel_7_9_gen2_sku" {
#   type        = string
#   description = "SKU for RHEL 7.9 Gen2"
#   default     = "79-gen2"
# }

# variable "rhel_8_4_sku" {
#   type        = string
#   description = "SKU for RHEL 8.4"
#   default     = "8_4"
# }

# variable "rhel_8_4_gen2_sku" {
#   type        = string
#   description = "SKU for RHEL 8.4 Gen2"
#   default     = "84-gen2"
# }

# variable "rhel_8_5_sku" {
#   type        = string
#   description = "SKU for RHEL 8.5"
#   default     = "8_5"
# }

# variable "rhel_8_5_gen2_sku" {
#   type        = string
#   description = "SKU for RHEL 8.5 Gen2"
#   default     = "85-gen2"
# }