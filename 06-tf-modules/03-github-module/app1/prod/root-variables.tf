variable "region" {
  type        = string
  default     = "westeurope"
  description = "Region for Location of the resource group."
}

variable "environment" {
  description = "Workload environment"
  type        = string
  default     = "prod"
}

variable "app_name" {
  description = "Application / Workload name"
  type        = string
  default     = "mod-github"
}


variable "cost_center" {
  type        = string
  description = "Cost Center for workload"
  default     = "00000"
}