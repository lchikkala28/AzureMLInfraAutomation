output "ds_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "ds_snet_id" {
  value = azurerm_virtual_network.subnet.id
}