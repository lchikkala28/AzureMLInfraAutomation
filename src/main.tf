terraform {
  required_version = ">= 1.5.7"
  required_providers {
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "3.108.0"
    # }
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
      purge_soft_delete_on_destroy       = false
      purge_soft_deleted_keys_on_destroy = false
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

# module "azureml" {
#   source = "./modules/compute/AzureML"  
#   environment = var.environment
#     depends_on = [
#     azurerm_resource_group.ds_rg
#     ]
# }
