
variable "ds_resource_group_name" {
  description = "The name of the wsi ds resource group"
  type        = string
  default     = "rg-d-race-ds-test"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}
variable "project" {
  type        = string
  description = "project name"
  default     = "MLOPS"
}

variable "environment" {
  type        = string
  description = "environment"
  default     = "dev"
}
variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
  default     = "ml"
}
variable "vendor" {
  type        = string
  description = "vendor name"
  default     = "RACE"
}

