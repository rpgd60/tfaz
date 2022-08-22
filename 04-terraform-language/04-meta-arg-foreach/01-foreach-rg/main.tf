variable "entity_type_name" {
  object(
    string
  )
}


resource "azurerm_resource_group" "rg_test_map" {
  for_each = {
    proj-a  = "apollo"
    proj-b  = "gemini"
    company = "acme"
    org     = "nasa"
  }

  location = "westeurope"
  name     = "rg-test-${each.key}-${each.value}"
}

resource "azurerm_resource_group" "rg_test_strings" {
  for_each = toset(["Finance", "IT", "HR"])
  location = "westeurope"
  name     = "rg-test-${each.value}"
}




output "rg_test_strings" {
  value = azurerm_resource_group.rg_test_strings
}

output "rg_test_object" {
  value = {
    for k,v in azurerm_resource_group.rg_test_map: k => v.name 
  }
}

# output "resource_group_names" {
#   value = azurerm_resource_group.rg-test[*].name
# }