# First module "call"
### Note we can call the module invocation with any name - not related at all with actual module name
module "first_static_website" {    
  source = "./modules/azure-static-website"

  # Resource Group
  region  = "westeurope"
  rg_name = "modreg1"

  # Storage Account
  storage_account_name              = "staticwebsite"
  storage_account_tier              = "Standard"
  storage_account_replication_type  = "LRS"
  storage_account_kind              = "StorageV2"
  static_website_index_document     = "index.html"
  static_website_error_404_document = "error.html"
}

# Second module "call"
# module "second_static_website" {
#   source = "./modules/azure-static-website"

#   # Resource Group
#   region  = "westeurope"
#   rg_name = "modreg2"

#   # Storage Account
#   storage_account_name              = "staticwebsite"
#   storage_account_tier              = "Standard"
#   storage_account_replication_type  = "LRS"
#   storage_account_kind              = "StorageV2"
#   static_website_index_document     = "index.html"
#   static_website_error_404_document = "error.html"
# }
