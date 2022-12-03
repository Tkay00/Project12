resource "random_password" "linux-vm-password" {
  length           = var.random_password_length
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric           = true
  special          = true
  override_special = "!@#$%&"
}

# locals {
#   VM1 = VM1-a
#   VM2 = VM1-b 
#   VM3 = VM2-a
#   VM4 = VM2-b
#   VM5 = VM3-a
#   VM6 = VM3-b
# }

data "azurerm_subnet" "vm-subnet" {
  name                 = var.vm_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.vm_resource_group                        #data.azurerm_resource_group.rg.name
}

resource "azurerm_public_ip" "publicip" {
  count               = var.instances_count2
  name                = lower("${length(var.rhel_vms)}nic${count.index}") #"${var.vm_resource_group}-lb-publicIP"
  location            = var.location
  resource_group_name = var.vm_resource_group
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  sku_tier            = var.public_ip_sku_tier
}

resource "azurerm_lb" "lb" {
  name                = "${var.vm_resource_group}-lb"
  location            = var.location
  resource_group_name = var.vm_resource_group
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.publicip["4"].id   
  }
}

resource "azurerm_lb_probe" "lb_probe" {
  name            = "${var.vm_resource_group}-lb_probe"
  loadbalancer_id = azurerm_lb.lb.id
  port            = var.application_port
  protocol        = var.protocol
}

resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_rule" "example" {
  resource_group_name            = var.vm_resource_group
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "RDPAccess"
  protocol                       = var.protocol
  frontend_port                  = var.frontend_port 
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_network_interface" "vm-nic" {
  count = var.instances_count
  name  = var.instances_count == 1 ? lower("nic-${format("vm%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")))}") : lower("nic-${format("vm%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index)}")
  location            = var.location
  resource_group_name = var.vm_resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = var.private_ip_address_allocation_type
    public_ip_address_id          = element(azurerm_public_ip.publicip.*.id, count.index)
  }                                 
}

resource "azurerm_network_interface_security_group_association" "nic-nsg-association" {
  count                     = var.instances_count
  network_interface_id      = element(azurerm_network_interface.vm-nic.*.id, count.index) 
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}

resource "azurerm_network_security_group" "vm-nsg" {
  name                = lower("${var.vm_subnet_name}-nsg")    
  location            = var.location
  resource_group_name = var.vm_resource_group

  security_rule {
    name                       = "AllowHTTP"
    description                = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association" {
  subnet_id                 = data.azurerm_subnet.vm-subnet.id
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}

resource "azurerm_linux_virtual_machine" "rhel" {
  for_each            = var.rhel_vms
  name                = each.value["name"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = each.value["size"]
  admin_username = var.admin_username
  admin_password = random_password.linux-vm-password.result
  disable_password_authentication = false
  network_interface_ids = [
     azurerm_network_interface.vm-nic["3"].id 
  ]

  source_image_reference {
    publisher = var.linux_distribution_list[lower(var.linux_distribution_name)]["publisher"]
    offer     = var.linux_distribution_list[lower(var.linux_distribution_name)]["offer"]
    sku       = var.linux_distribution_list[lower(var.linux_distribution_name)]["sku"]
    version   = var.linux_distribution_list[lower(var.linux_distribution_name)]["version"]
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = each.value["disk_size_gb"]
    name                 = each.value["os_disk_name"]
  }  
}