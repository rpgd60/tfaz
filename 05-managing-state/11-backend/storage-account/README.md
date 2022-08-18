Creating the Azure storage account and container for  Terraform remote state

These resources must be created separately and outside of any actual Azure infrastructure created with Terraform
In a way they are "meta resources"

They can be created manually in the portal,  using CLI or Power Shell,  and also with Terraform (what we are doing here)

Microsoft Azure documentation 
https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=terraform
Note that this doc is based on azurerm provider 2.x.  
For 3.x change
OLD:  allow_blob_public_access = true <<<- no longer valid in version 3.x of azurerm provider
NEW:  allow_nested_items_to_be_public = true    ## new in version 3.x of azurem provider

Resource names try to follow Microsoft naming best practices
https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming


### Import example

error when apply create
Changes to Outputs:
  + backend_rg_group_name          = "rg-tfbackend-infra-westeurope"
  + backend_storage_account_name   = (known after apply)
  + backend_storage_container_name = "stc-tfbackend-infra-westeurope"
random_string.resource_code: Creating...
random_string.resource_code: Creation complete after 0s [id=91sr3]
azurerm_resource_group.tf_backend: Creating...
╷
│ Error: A resource with the ID "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-tfbackend-infra-westeurope" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_resource_group" for more information.
│ 
│   with azurerm_resource_group.tf_backend,
│   on main.tf line 19, in resource "azurerm_resource_group" "tf_backend":
│   19: resource "azurerm_resource_group" "tf_backend" {

    
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
specifics of RG taken from error message above

terraform import azurerm_resource_group.tf_backend /subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-tfbackend-infra-westeurope


rafas-MacBook-Air:storage-account rafa$ terraform import azurerm_resource_group.tf_backend /subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-tfbackend-infra-westeurope
azurerm_resource_group.tf_backend: Importing from ID "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-tfbackend-infra-westeurope"...
azurerm_resource_group.tf_backend: Import prepared!
  Prepared azurerm_resource_group for import
azurerm_resource_group.tf_backend: Refreshing state... [id=/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-tfbackend-infra-westeurope]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

