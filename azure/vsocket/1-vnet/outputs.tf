## The following attributes are exported:
output "resource-group-name" { value = azurerm_resource_group.azure-rg.name }
output "mgmt-nic-id" { value = azurerm_network_interface.mgmt-nic.id }
output "wan-nic-id" { value = azurerm_network_interface.wan-nic.id }
output "lan-nic-id" { value = azurerm_network_interface.lan-nic.id }
output "lan_subnet_id" { value = azurerm_subnet.subnet-lan.id }