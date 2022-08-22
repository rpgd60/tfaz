terraform {
  required_version = "~>1.2.0"

  required_providers {
    azurerm = {
      #source = "registry.terraform.io/hashicorp/azurerm"
      source  = "hashicorp/azurerm" 
      version = "~>3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
    gcp = {
      source = "hashicorp/google"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.3"
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
  #  # subscription_id = "xxxx"
}


provider "aws" {
  region  = "eu-west-1"
  profile = "tfprofile"
}

