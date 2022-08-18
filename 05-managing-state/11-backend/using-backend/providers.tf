terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  required_version = "~>1.2.0"

  backend "azurerm" {
    resource_group_name  = "rg-tfbackend-infra-westeurope"
    storage_account_name = "backend5qrd0"
    container_name       = "stc-tfbackend-infra-westeurope"
    key                  = "demo-proj-2/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
