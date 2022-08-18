locals {

  flat_list = setproduct(var.all_environments, var.containers)
  rg_names = {
    for k, v in azurerm_resource_group.rg_env : k => v.name
  }
}

locals {
  #   name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  tags = {
    Source = "terraform"
    # Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
  }
}

resource "random_string" "rnd" {
  for_each = toset(var.all_environments)
  length  = 6
  upper   = false
  special = false
  numeric = false
}
resource "azurerm_resource_group" "rg_env" {
  for_each = toset(var.all_environments)
  name     = join("-", ["rg", var.app_name, each.value, var.region])
  location = var.region
  tags = merge(
    local.tags,
    {
      "Env" = each.value
    }
  )
}

resource "azurerm_storage_account" "storage_account" {
  for_each                 = toset(var.all_environments)
  name                     = join("", [var.storage_base_name, each.value, random_string.rnd[each.value].result])
  resource_group_name      = azurerm_resource_group.rg_env[each.value].name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "container" {
  for_each              = {for idx, val in local.flat_list: idx => val}
  # name                  = each.value.name[1].name
  # container_access_type = each.value.name[1].access_type
  name                  = each.value[1].name
  container_access_type = each.value[1].access_type
  storage_account_name  = azurerm_storage_account.storage_account[each.value[0]].name
}