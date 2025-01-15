variable "ds_resource_group_name" {
  description = "The name of the wsi resource group"
  type        = string
  default = "rg-d-race-ds"
}
variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}
variable "environment" {
  type        = string
  description = "Name of the environment"
  default     = "dev"
}

variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
  default     = "ml"
}