terraform {
  required_version = "~>1.2.0"

  required_providers {
    azurerm = {
      source = "registry.terraform.io/hashicorp/azurerm"
      # source  = "hashicorp/azurerm" 
      version = "~>3.0"
      # version = "3.10.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.25.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.3.2"
    }
  }


}



provider "azurerm" {
  features {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
    # virtual_machine_scale_set {
    #   force_delete                  = false
    #   roll_instances_when_required  = true
    #   scale_to_zero_before_deletion = true
    # }
  }
  environment = "public"
  #  subscription_id = "a1e01a15-61aa-4f25-aa66-6d6e8a913dc3"
}


provider "aws" {
  region  = "eu-west-1"
  profile = "tfprofile"
}

