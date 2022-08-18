variable "region" {
  type        = string
  default     = "westeurope"
  description = "Region for Location of the resource group."
}

variable "environment" {
  description = "Workload environment"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application / Workload name"
  type        = string
  default     = "modules-02"
}


variable "cost_center" {
  type        = string
  description = "Cost Center for workload"
  default     = "00000"
}