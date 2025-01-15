# Dependent resources for Azure Machine Learning
resource "azurerm_application_insights" "default" {
  name                = "${var.environment}-${random_pet.prefix.id}-appi"
  location            = var.location
  resource_group_name = var.ds_resource_group_name
  application_type    = "web"
}

resource "azurerm_key_vault" "default" {
  name                     = "${var.environment}-${var.prefix}-${random_integer.suffix.result}kv"
  location                 = var.location
  resource_group_name      =  var.ds_resource_group_name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "premium"
  purge_protection_enabled = false
}

resource "azurerm_storage_account" "default" {
  name                            = "${var.environment}${var.prefix}${random_integer.suffix.result}sa"
  location                        = var.location
  resource_group_name             =  var.ds_resource_group_name
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_container_registry" "default" {
  name                = "${var.environment}${var.prefix}${random_integer.suffix.result}cr"
  location            = var.location
  resource_group_name =  var.ds_resource_group_name
  sku                 = "Premium"
  admin_enabled       = true
}

# Machine Learning workspace
resource "azurerm_machine_learning_workspace" "default" {
  name                          = "${var.environment}-${random_pet.prefix.id}-mlw"
  location                      = var.location
  resource_group_name           = var.ds_resource_group_name
  application_insights_id       = azurerm_application_insights.default.id
  key_vault_id                  = azurerm_key_vault.default.id
  storage_account_id            = azurerm_storage_account.default.id
  container_registry_id         = azurerm_container_registry.default.id
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }
}

# Compute Cluster
resource "azurerm_machine_learning_compute_cluster" "compute" {
  name                          = "cpu-cluster"
  location                      = var.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.default.id
  vm_priority                   = "Dedicated"
  vm_size                       = "STANDARD_D2S_V3"

  identity {
    type = "SystemAssigned"
  }

  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 3
    scale_down_nodes_after_idle_duration = "PT15M" # 15 minutes
  }

}