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
  # subscription_id = "xxxx"
}
