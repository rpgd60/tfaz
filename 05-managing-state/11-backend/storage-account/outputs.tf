output "backend_storage_account_name" {
  value = azurerm_storage_account.tf_backend.name
}

output "backend_storage_container_name" {
  value = azurerm_storage_container.tf_backend.name
}

output "backend_rg_group_name" {
  value = azurerm_resource_group.tf_backend.name
}