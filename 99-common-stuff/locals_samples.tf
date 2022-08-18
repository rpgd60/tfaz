locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  tags = {
    Source          = "terraform"
    Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
  }
}


## Locals for backend storage accounts

