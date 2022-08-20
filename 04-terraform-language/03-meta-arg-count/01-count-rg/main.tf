variable "create_rg" {
  default = true
  type = bool
}
variable "num_rg" {
  default = 2
}

resource "azurerm_resource_group" "rg_test" {
  count          = var.create_rg ? var.num_rg : 0
  name     = "rg-prueba-${count.index}"
  location = "westeurope"
}

output "resource_groups" {
  value = azurerm_resource_group.rg_test
}

output "resource_group_names" {
  value = azurerm_resource_group.rg_test[*].name
}

output "zip" {
  value = zipmap(azurerm_resource_group.rg_test[*].name, azurerm_resource_group.rg_test[*].location)
}