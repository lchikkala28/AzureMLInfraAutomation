
ds_resource_group_name = "rg-dev-race-ds"
location =  "East US"
project = "MLOps"
environment = "dev"
prefix = "ml"

#network
vnet_name = "ds_ml_vnet"
snet_name = "ds_ml_snet"
vnet_address = ["192.168.0.0/16"]
snet_address = ["192.168.0.0/24"]
snet_delegation_name = "ml-delegation"
service_delegation_name = "Microsoft.MachineLearningServices/workspaces"
snet_actions =  ["Microsoft.Network/virtualNetworks/subnets/join/action"]
pe_snet_name = "ds_ml_pe_snet"
pe_snet_address = ["192.168.1.0/24"]

#Mmachine learning workspace
appinsights_name = "ds_appinsights"
applicationtype = "web"
akv_name = "dsakv2216" #change this name as akv has purge protection
akv_sku_name = "premium"
akv_purge_protection_enabled = false
sa_name ="dssa"
sa_account_tier = "Standard"
sa_account_replication_type = "GRS"
sa_allow_nested_items_to_be_public = false
containerregistry_name = "dsconreg"
container_registry_sku = "Premium"
container_registry_admin_enabled = true
mlworkspace_name = "dsws"
ml_ws_public_network_access_enabled = true
ml_compute_cluster = "cpu-cluster"
ml_vm_priority = "Dedicated"
ml_vm_size = "STANDARD_D2S_V3"
ml_vm_min_node_count = 0
ml_vm_max_node_count = 3
ml_vm_scale_down_ideal_time = "PT15M"
#ml private endpoint
ml_pe_name = "ml_pe"
ml_pe_service_connection = "ml-private-connection"
ml_pe_is_manual_connection = false
ml_pe_subresource_names = ["amlworkspace"]