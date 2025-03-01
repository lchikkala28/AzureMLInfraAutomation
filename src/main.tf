terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.108.0"
    }
  }
  backend "azurerm" {
  }
}
data "azurerm_client_config" "current" {}

provider "azurerm" {
  # Configuration options  
  features {
    key_vault {
      recover_soft_deleted_key_vaults    = false
      purge_soft_delete_on_destroy       = true
      purge_soft_deleted_keys_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "2e5e8dc1-e03b-48a5-8ad0-9166cecca320"
}

resource "azurerm_resource_group" "ds_rg" {
  name     = var.ds_resource_group_name
  location = var.location
  tags = {
    environment = var.environment
    project     = var.project
    vendor      = var.vendor
  }
}

module "network" {
  source                  = "./modules/Security/Networking"
  location                = var.location
  resource_group_name     = var.ds_resource_group_name
  vnet_name               = var.vnet_name
  snet_name               = var.snet_name
  vnet_address            = var.vnet_address
  snet_address            = var.snet_address
  snet_delegation_name    = var.snet_delegation_name
  service_delegation_name = var.service_delegation_name
  snet_actions            = var.snet_actions
  pe_snet_name            = var.pe_snet_name
  pe_snet_address         = var.pe_snet_address
  depends_on = [
    azurerm_resource_group.ds_rg
  ]
}

module "azureml" {
  source                              = "./modules/compute/AzureML"
  environment                         = var.environment
  location                            = var.location
  ds_resource_group_name              = var.ds_resource_group_name
  prefix                              = var.prefix
  appinsights_name                    = var.appinsights_name
  applicationtype                     = var.applicationtype
  akv_name                            = var.akv_name
  akv_sku_name                        = var.akv_sku_name
  akv_purge_protection_enabled        = var.akv_purge_protection_enabled
  sa_name                             = var.sa_name
  sa_account_tier                     = var.sa_account_tier
  sa_account_replication_type         = var.sa_account_replication_type
  sa_allow_nested_items_to_be_public  = var.sa_allow_nested_items_to_be_public
  containerregistry_name              = var.containerregistry_name
  container_registry_sku              = var.container_registry_sku
  container_registry_admin_enabled    = var.container_registry_admin_enabled
  mlworkspace_name                    = var.mlworkspace_name
  ml_ws_public_network_access_enabled = var.ml_ws_public_network_access_enabled
  ml_compute_cluster                  = var.ml_compute_cluster
  ml_vm_priority                      = var.ml_vm_priority
  ml_vm_size                          = var.ml_vm_size
  ml_vm_min_node_count                = var.ml_vm_min_node_count
  ml_vm_max_node_count                = var.ml_vm_max_node_count
  ml_vm_scale_down_ideal_time         = var.ml_vm_scale_down_ideal_time
  ml_pe_name                          = var.ml_pe_name
  ml_pe_service_connection            = var.ml_pe_service_connection
  ml_pe_is_manual_connection          = var.ml_pe_is_manual_connection
  ml_pe_subresource_names             = var.ml_pe_subresource_names
  snet_id                             = module.network.ds_pe_snet_id
  depends_on = [
    azurerm_resource_group.ds_rg,
    module.network
  ]
}
