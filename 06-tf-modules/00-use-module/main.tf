locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  dns_name    = var.app_name
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
module "first_vnet" {
  source              = "Azure/vnet/azurerm"
  version             = "2.7.0" # In production use always a locked specific version (no ">=", "~>" etc)
  vnet_name           = "vnet-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.7.0.0/16"]
  subnet_prefixes     = ["10.7.1.0/24", "10.7.2.0/24"]
  subnet_names        = ["snet-${local.name_suffix}-1", "snet-${local.name_suffix}-2"]
  tags                = local.tags
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_network_interface" "first_nic" {
  name                = "nic-${local.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "NicConfig"
    # subnet_id                     = azurerm_subnet.tfub_subnet.id
    subnet_id                     = module.first_vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.tags
}

module "second_vnet" {
  source              = "Azure/vnet/azurerm"
  version             = "2.7.0" # In production use always a locked specific version (no ">=", "~>" etc)
  vnet_name           = "vnet-${local.name_suffix}-2"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.7.0.0/16"]
  subnet_prefixes     = ["10.7.1.0/24", "10.7.2.0/24"]
  subnet_names        = ["snet-${local.name_suffix}-1", "snet-${local.name_suffix}-2"]
  tags                = local.tags
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_network_interface" "second_nic_in_second_vnet" {
  name                = "nic-${local.name_suffix}-2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "NicConfig"
    # subnet_id                     = azurerm_subnet.tfub_subnet.id
    subnet_id                     = module.second_vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.tags
}
