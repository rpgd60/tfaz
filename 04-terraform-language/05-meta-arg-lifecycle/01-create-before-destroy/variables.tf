variable "region" {
  type        = string
  default     = "westeurope"
  description = "Region for Location of the resource group."

  validation {
    condition     = contains(["eastus", "westeurope"], var.region)
    error_message = "Err: Region not allowed."
  }
}

variable "app_name" {
  type        = string
  description = "Application / Workload name"
}

# variable "project" {
#   type        = string
#   default     = "acme"
#   description = "Project name"
# }

variable "environment" {
  type        = string
  default     = "dev"
  description = "Workload environment"

  validation {
    condition     = can(regex("^dev$|^prod$", var.environment))
    error_message = "Err: invalid environment."
  }

  validation {
    condition     = length(var.environment) <= 4
    error_message = "Err: environment is too long."
  }
}

variable "cost_center" {
  type        = string
  description = "Cost Center for workload"
  default     = "00000"
}

## VM Parameters
variable "vm_size" {
  type        = string
  description = "VM Size"
  default     = "Standard_DS1_v2"
}

variable "ssh_user" {
  type        = string
  description = "Username for ssh to VM"
  default     = "azureuser"
}

variable "ssh_pub_key_file" {
  type        = string
  description = "file for SSH public key"
  default     = "~/.ssh/mykey.pub"
}


