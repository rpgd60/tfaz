output "rg_names" {
  value = {
    for k, v in azurerm_resource_group.rg_env : k => v.name
  }
}

output "storage_account_names" {
  value = {
    for k, v in azurerm_storage_account.storage_account : k => v.name
  }
}