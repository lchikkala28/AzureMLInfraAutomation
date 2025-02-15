variable "resource_group_name" {
  description = "The name of the MLOPS resource group"
  type        = string  
}
variable "location" {
  description = "The location of the resources"
  type        = string  
}
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
variable "snet_actions" {
  type        = list(string)
  description = "List of actions"
  default = [] 
}
