locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  dns_name = var.app_name
  tags = {
    Source          = "terraform"
    Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_suffix}"
  location = var.region
  tags     = local.tags
}

# Code commented below is replaced by the module call

## Create virtual network and subnets using resources
# # Create virtual network
# resource "azurerm_virtual_network" "tfub_network" {
#   name                = "vnet-${local.name_suffix}"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   tags                = local.tags
# }

# # Create subnet
# resource "azurerm_subnet" "tfub_subnet" {
#   name                 = "snet-${local.name_suffix}"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.tfub_network.name
#   address_prefixes     = ["10.0.1.0/24"]
# }


# Create Virtual Network and Subnets using Terraform Public Registry Module
# https://registry.terraform.io/modules/Azure/vnet/azurerm/latest
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "2.7.0" # In production use always a locked specific version (do not use >=  ~> etc.)
  vnet_name = "vnet-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.7.0.0/16"]
  subnet_prefixes     = ["10.7.1.0/24", "10.7.2.0/24"]
  subnet_names        = ["snet-${local.name_suffix}-1", "snet-${local.name_suffix}-2"]
  tags = local.tags
  depends_on = [azurerm_resource_group.rg]   
}

# Create public IPs
resource "azurerm_public_ip" "tfub_publicip" {
  name                = "pip-${local.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = local.dns_name
  tags                = local.tags

}

# Create network interface
resource "azurerm_network_interface" "tfub_nic" {
  name                = "nic-${local.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NicConfig"
    # subnet_id                     = azurerm_subnet.tfub_subnet.id
    subnet_id = module.vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tfub_publicip.id
  }
  tags = local.tags
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "tfub_nsg" {
  name                = "nsg-${local.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}


resource "azurerm_network_security_rule" "ssh" {
  name                        = "nsgr-SSH"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.tfub_nsg.name
}

resource "azurerm_network_security_rule" "icmp" {
  name                        = "nsgr-igmp"
  priority                    = 1102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.tfub_nsg.name
}



# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.tfub_nic.id
  network_security_group_id = azurerm_network_security_group.tfub_nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "tfub_vm" {
  depends_on = [
    azurerm_network_interface_security_group_association.example
  ]
  name                  = "vm-${local.name_suffix}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.tfub_nic.id]
  size                  = var.vm_size

  os_disk {
    name                 = "osd-${local.name_suffix}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = local.dns_name
  admin_username                  = var.ssh_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.ssh_pub_key_file)
  }

  # boot_diagnostics {
  #   storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
  # }
  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags,             ## Prevents TF from removing tags added to the VM outside of Terraform (e.g. by a mgmt application)
    ]
  }
}