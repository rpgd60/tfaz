locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  tags = {
    Source          = "terraform"
    Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
  }
}

resource "azurerm_resource_group" "rem_state_demo" {
  name     = "rg-${local.name_suffix}"
  location = var.region
  tags = local.tags
}

# Create virtual network
resource "azurerm_virtual_network" "rem_state_network" {
  name                = "vnet-${local.name_suffix}"
  address_space       = ["10.7.0.0/16"]
  location            = azurerm_resource_group.rem_state_demo.location
  resource_group_name = azurerm_resource_group.rem_state_demo.name
  tags                = local.tags
}

# Create subnet
resource "azurerm_subnet" "rem_state_subnet" {
  name                 = "snet-${local.name_suffix}"
  resource_group_name  = azurerm_resource_group.rem_state_demo.name
  virtual_network_name = azurerm_virtual_network.rem_state_network.name
  address_prefixes     = ["10.7.1.0/24"]
}