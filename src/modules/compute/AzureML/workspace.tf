# Dependent resources for Azure Machine Learning
resource "azurerm_application_insights" "mlappinsight" {
  name                = "${var.environment}-${var.prefix}-${var.appinsights_name}-${random_pet.prefix.id}"
  location            = var.location
  resource_group_name = var.ds_resource_group_name
  application_type    = var.applicationtype
}

resource "azurerm_key_vault" "mlakv" {
  name                     = "${var.environment}-${var.prefix}-${var.akv_name}"
  location                 = var.location
  resource_group_name      = var.ds_resource_group_name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = var.akv_sku_name
  purge_protection_enabled = var.akv_purge_protection_enabled
}

resource "azurerm_storage_account" "mlsa" {
  name                            = "${var.environment}${var.prefix}${var.sa_name}${random_integer.suffix.result}"
  location                        = var.location
  resource_group_name             = var.ds_resource_group_name
  account_tier                    = var.sa_account_tier
  account_replication_type        = var.sa_account_replication_type
  allow_nested_items_to_be_public = var.sa_allow_nested_items_to_be_public
}

resource "azurerm_container_registry" "mlconregistry" {
  name                = "${var.environment}${var.prefix}${var.containerregistry_name}${random_integer.suffix.result}"
  location            = var.location
  resource_group_name = var.ds_resource_group_name
  sku                 = var.container_registry_sku
  admin_enabled       = var.container_registry_admin_enabled
}

# Machine Learning workspace
resource "azurerm_machine_learning_workspace" "mlworkspace" {
  name                          = "${var.environment}-${var.prefix}-${var.mlworkspace_name}-${random_pet.prefix.id}"
  location                      = var.location
  resource_group_name           = var.ds_resource_group_name
  application_insights_id       = azurerm_application_insights.mlappinsight.id
  key_vault_id                  = azurerm_key_vault.mlakv.id
  storage_account_id            = azurerm_storage_account.mlsa.id
  container_registry_id         = azurerm_container_registry.mlconregistry.id
  public_network_access_enabled = var.ml_ws_public_network_access_enabled

  identity {
    type = "SystemAssigned"
  }
}

# Compute Cluster
resource "azurerm_machine_learning_compute_cluster" "compute" {
  name                          = var.ml_compute_cluster
  location                      = var.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mlworkspace.id
  vm_priority                   = var.ml_vm_priority
  vm_size                       = var.ml_vm_size

  identity {
    type = "SystemAssigned"
  }

  scale_settings {
    min_node_count                       = var.ml_vm_min_node_count
    max_node_count                       = var.ml_vm_max_node_count
    scale_down_nodes_after_idle_duration = var.ml_vm_scale_down_ideal_time # 15 minutes
  }

}

resource "azurerm_private_endpoint" "aml_pe" {
  name                = "${var.environment}${var.ml_pe_name}"
  location            = var.location
  resource_group_name = var.ds_resource_group_name
  subnet_id           = var.snet_id

  private_service_connection {
    name                           = "${var.environment}${var.ml_pe_service_connection}"
    private_connection_resource_id = azurerm_machine_learning_workspace.mlworkspace.id
    is_manual_connection           = var.ml_pe_is_manual_connection
    subresource_names              = var.ml_pe_subresource_names
  }
}