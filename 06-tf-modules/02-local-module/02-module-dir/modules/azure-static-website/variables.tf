variable "region" {
  description = "Azure Region for resources"
  type        = string
}
variable "rg_name" {
  description = "Resource group name"
  type        = string
}
variable "storage_account_name" {
  description = "Storage account"
  type        = string
}
variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
}
variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string
}
variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
}
variable "static_website_index_document" {
  description = "static website index document"
  type        = string
}
variable "static_website_error_404_document" {
  description = "static website error 404 document"
  type        = string
}

variable "module_tags" {
  description = "tags to be applied to resources created by module"
  # type = object
}