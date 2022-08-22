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
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  environment     = "public"
  subscription_id = "a1e01a15-61aa-4f25-aa66-6d6e8a913dc3"
}
