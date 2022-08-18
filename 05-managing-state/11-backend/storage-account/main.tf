locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  tags = {
    Source          = "terraform"
    Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
  }
}



resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tf_backend" {
  name     = "rg-${local.name_suffix}"
  location = var.region


  lifecycle {
    prevent_destroy = true
  }

}

resource "azurerm_storage_account" "tf_backend" {
  name                     = "backend${random_string.resource_code.result}" ## special length and character constraints
  resource_group_name      = azurerm_resource_group.tf_backend.name
  location                 = azurerm_resource_group.tf_backend.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  #   allow_blob_public_access = true <<<- no longer valid in version 3.x of azurerm provider
  allow_nested_items_to_be_public = true ## new in version 3.x of azurem provider
  blob_properties {
    versioning_enabled = true
  }
  tags = local.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "tf_backend" {
  name                  = "stc-${local.name_suffix}"
  storage_account_name  = azurerm_storage_account.tf_backend.name
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}