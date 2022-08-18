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
  }
  environment     = "public"
  subscription_id = "a1e01a15-61aa-4f25-aa66-6d6e8a913dc3"
}
