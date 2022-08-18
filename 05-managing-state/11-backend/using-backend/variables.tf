
variable "region" {
  type        = string
  default     = "westeurope"
  description = "Region for Location of the resource group."
}

variable "app_name" {
  type        = string
  default     = "rem-state-demo"
  description = "Application / Workload name"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "Workload environment"
}

variable "cost_center" {
  type        = string
  description = "Cost Center for workload"
  default     = "000233"
}


