
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


#Networking
variable "vnet_name" {  
  type        = string
}
variable "snet_name" {  
  type        = string
}
variable "service_delegation_name" {  
  type        = string
}
variable "vnet_address" {
  type        = list(string)
  description = "List of vnet ip."
  default = []
}
variable "snet_address" {
  type        = list(string)
  description = "List of subnet ip."
  default = [] 
}
variable "snet_delegation_name" {
  type        = string
}




# ML workspace
variable "applicationtype" {
  type = string
  description = "application type"  
}
variable "akv_sku_name" {
  type = string
  description = "azure key vault sku name"
}
variable "akv_purge_protection_enabled" {
  type = bool
  description = "azure purge protection enabled"  
}
variable "sa_account_tier" {
  type = string
  description = "azure storage account tier"  
}
variable "sa_account_replication_type" {
  type = string
  description = "azure storage account replication type"  
}
variable "sa_allow_nested_items_to_be_public" {
  type = bool
  description = "azure sa allow nested items to be public"  
}

variable "container_registry_sku" {
  type = string
  description = "azure container registry sku name"  
}
variable "container_registry_admin_enabled" {
  type = bool
  description = "azure container registery admin enable"  
}

variable "ml_ws_public_network_access_enabled" {
  type = bool
  description = "azure machine learning workspace enable"  
}
variable "ml_compute_cluster" {
  type = string
  description = "azure machine learning compute cluster name"  
}
variable "ml_vm_priority" {
  type = string
  description = "azure vm priority"  
}
variable "ml_vm_size" {
  type = string
  description = "azure vm size"  
}
variable "ml_vm_min_node_count" {
  type = number
  description = "azure vm min node count"  
}
variable "ml_vm_max_node_count" {
  type = number
  description = "azure vm max node count"  
}

variable "ml_vm_scale_down_ideal_time" {
  type = string
  description = "azure vm scale down after ideal time"  
}

#private endpoint

variable "ml_pe_name" {
  type = string
  description = "azure machine learning private end point name"  
}
variable "ml_pe_service_connection" {
  type = string
  description = "azure machine learning private end point service connection"  
}

variable "ml_pe_is_manual_connection" {
  type = bool
  description = "azure machine learning private end point enable"
  #false  
}
variable "ml_pe_subresource_names" {
  type        = list(string)
  description = "List of subresource names"
  default = [] 
}