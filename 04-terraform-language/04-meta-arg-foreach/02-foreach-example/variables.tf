
variable "all_environments" {
  type    = list(string)
  # default = ["dev", "prod"]
}

variable "containers" {
  type = list(object({
    name        = string
    access_type = string
  }))
  default     = []
  description = "List of storage account containers."
}

variable "storage_base_name" {
  type = string
  validation {
    condition     = length(var.storage_base_name) <= 10
    error_message = "Err: storage_name base name is too long."
  }

  validation {
    condition     = can(regex("[a-z0-9]+", var.storage_base_name))
    error_message = "Err: storage_name base can only contain lowercase letters and numbers."
  }

}

variable "region" {
  type = string
  #   default     = "westeurope"
  description = "Region for Location of the resource group."

  validation {
    condition     = contains(["eastus", "westeurope"], var.region)
    error_message = "Err: Region not allowed."
  }
}


variable "app_name" {
  type        = string
  default     = "foreach-example"
  description = "Application / Workload name"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Workload environment"

  validation {
    condition     = can(regex("^dev$|^prod$|^test$", var.environment))
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

variable "dns_name" {
  type        = string
  default     = "vm-test1"
  description = "Host name"
}

