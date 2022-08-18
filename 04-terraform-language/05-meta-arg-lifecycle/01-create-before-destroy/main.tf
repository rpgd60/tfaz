locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  dns_name    = "${var.app_name}-${random_string.rnd.result}"
  tags = {
    Source          = "terraform"
    Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
    # Project         = var.project
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_suffix}"
  location = var.region
  tags     = local.tags
}

resource "random_string" "rnd" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}
