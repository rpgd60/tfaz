terraform {
  required_version = "~>1.2.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
    # virtual_machine {
    #   delete_os_disk_on_deletion     = true
    #   graceful_shutdown              = false
    #   skip_shutdown_and_force_delete = false
    # }

    # virtual_machine_scale_set {
    #   force_delete                  = false
    #   roll_instances_when_required  = true
    #   scale_to_zero_before_deletion = true
    # }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  environment = "public"
  subscription_id = "a1e01a15-61aa-4f25-aa66-6d6e8a913dc3"
}
