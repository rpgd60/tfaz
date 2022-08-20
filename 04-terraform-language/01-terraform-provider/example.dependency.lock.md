## Initial configuration

Note : at the time of the writing the latest azurerm version was 3.18.0
```
terraform {
  required_version = "~>1.2.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # version = "~>3.0"
      version = "3.10.0"
    }

    aws = {
      source = "hashicorp/aws"
      version = ">= 4.25.0"
    } 
  }
}
```

## Output of terraform init

rafa@rp3:01-terraform-provider$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 4.25.0"...
- Finding hashicorp/azurerm versions matching "3.10.0"...
- Installing hashicorp/azurerm v3.10.0...
- Installed hashicorp/azurerm v3.10.0 (signed by HashiCorp)
- Using hashicorp/aws v4.26.0 from the shared cache directory

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

## Contents of lock file

rafa@rp3:01-terraform-provider$ cat .terraform.lock.hcl 

provider "registry.terraform.io/hashicorp/aws" {
  version     = "4.26.0"
  constraints = ">= 4.25.0"
  hashes = [
    "h1:jt8jLpFFhaapdbBqw4WQpDuLN8y7zF8/iLyCzypDxSQ=",
  ]
}

provider "registry.terraform.io/hashicorp/azurerm" {
  version     = "3.10.0"
  constraints = "3.10.0"
  hashes = [
    "h1:pa+WRfGci/bQBLpuL/QOX91iu1vSf5gPsHmYzH/a+EE=",
    "zh:01f749bc6f5fde7ef1dcdf741d32fe05cb3e6b3b550659981c7aaff6ee47a55e",
    "zh:1d6525872c6cf2c2437b3dfff34b285fd00cb2b8d55d9b0686738887fbdae6ea",
    "zh:3c1a9fa26d3e455275ddfc2b72e8173cdb83ae75500eb0e8dd6f080e26d1b177",
    "zh:4473f70d638967157b61f2e56c672455418714c77a2974c98b0c4e19d28ed560",
    "zh:567778e1d9df13925d54da963e9ca7aebada3bc444e78a87a79f17dc0aa8b23b",
    "zh:6c3c9722b24d9f976ae0da02af15f9b7f734a835e82658af899cff8d928e9170",
    "zh:6fde9333c15428439913dd62c440f127e6637904fa460282593fab384ae0469c",
    "zh:8d44cc5f93359a30e3d3df9d9eca80056d34d2fff31e47e0883dbf181ed7151b",
    "zh:8e3b9bb10c1241621ceeaf73db12256f8ff94d9fcc0bc26ac2936751c22e2f13",
    "zh:a5c9386bb557d19cb5538f6273c76b1756e2f9e6a75d3bb8b0df04a09086a709",
    "zh:a673c4fea86b5f2cd5602077e712abf08410d1ec10c1ae2d346a6f5bc3548419",
    "zh:f569b65999264a9416862bca5cd2a6177d94ccb0424f3a4ef424428912b9cb3c",
  ]
}


### Modify constraint allowing a higher version (but not imposing it)
terraform {
  required_version = "~>1.2.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
      # version = "3.10.0"
    }

    aws = {
      source = "hashicorp/aws"
      version = ">= 4.25.0"
    } 
  }
}

## Try again terraform init
Even if the config constraint (>3.0) allows a higher version and one is available (3.18.0), it will stick to the one in the lock file (3.10.0)

rafa@rp3:01-terraform-provider$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/azurerm v3.10.0
- Using previously-installed hashicorp/aws v4.26.0

Terraform has been successfully initialized!

## Now try terraform init -upgrade

rafa@rp3:01-terraform-provider$ terraform init -upgrade

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 3.0"...
- Finding hashicorp/aws versions matching ">= 4.25.0"...
- Using hashicorp/azurerm v3.18.0 from the shared cache directory
- Using previously-installed hashicorp/aws v4.26.0

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

## Contents of lock file
```t
rafa@rp3:01-terraform-provider$ cat .terraform.lock.hcl
# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/hashicorp/aws" {
  version     = "4.26.0"
  constraints = ">= 4.25.0"
  hashes = [
    "h1:jt8jLpFFhaapdbBqw4WQpDuLN8y7zF8/iLyCzypDxSQ=",
  ]
}

provider "registry.terraform.io/hashicorp/azurerm" {
  version     = "3.18.0"
  constraints = "~> 3.0"
  hashes = [
    "h1:JP1ql3IvCpG1f88Zfb+W0Gm9kRKHg2c+VXOfVKpHZTY=",
  ]
}
```
