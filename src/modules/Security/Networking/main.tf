resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address
  location            = var.location
  resource_group_name = var.resource_group_name
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.snet_name
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_address
  delegation {
    name = var.snet_delegation_name
    service_delegation {
      name = var.service_delegation_name
      actions = var.snet_actions
    }
  }
}