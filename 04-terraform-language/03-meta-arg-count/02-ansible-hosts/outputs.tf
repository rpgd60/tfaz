output "resource_group_name" {
  description = "Name of resource group"
  value       = azurerm_resource_group.rg.name
}

output "public_ip" {
  description = "Public IP assigned to the VM"
  value       = azurerm_linux_virtual_machine.tfub_vm[*].public_ip_address
}

output "private_ip" {
  description = "Private IP assigned to the VM"
  value       = azurerm_linux_virtual_machine.tfub_vm[*].private_ip_address
}

output "full_machine_name" {
  description = "FQDN of the Public IP assigned to the VM"
  value       = azurerm_public_ip.tfub_publicip[*].fqdn
}

output "name_suffix" {
  description = "Comon suffix used for resource naming"
  value       = local.name_suffix
}

output "fqdn_pubip" {
  value = zipmap(azurerm_public_ip.tfub_publicip[*].fqdn, azurerm_linux_virtual_machine.tfub_vm[*].public_ip_address)
}

output "draft_of_ansible_file" {
  value = local.ansible_hosts_content
}

output "client_config" {
  
value = data.azurerm_client_config.current

}