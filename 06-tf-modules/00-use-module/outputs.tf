output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}


output "first_vnet_info" {
  value = module.first_vnet
}

output "first_vnet_address_space" {
  value = module.first_vnet.vnet_address_space
}

output "second_vnet_address_space" {
  value = module.second_vnet.vnet_address_space
}
