resource "azurerm_resource_group" "rg-test" {
  count    = 3
  location = "westeurope"
  name     = "rg-test-${count.index}"
}

output "resource_groups" {
  value = azurerm_resource_group.rg-test
}

output "resource_group_names" {
  value = azurerm_resource_group.rg-test[*].name
}