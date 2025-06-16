## The following attributes are exported:
output "resource_group_name" {
  description = "The name of the Azure resource group."
  value       = azurerm_resource_group.azure-rg.name
}

output "resource_group_location" {
  description = "The location of the Azure resource group."
  value       = azurerm_resource_group.azure-rg.location
}

output "mgmt-nic-id" {
  description = "The ID of the management network interface."
  value       = azurerm_network_interface.mgmt-nic.id
}

output "wan-nic-id" {
  description = "The ID of the WAN network interface."
  value       = azurerm_network_interface.wan-nic.id
}

output "lan-nic-id" {
  description = "The ID of the LAN network interface."
  value       = azurerm_network_interface.lan-nic.id
}

output "lan_subnet_id" {
  description = "The ID of the LAN subnet."
  value       = azurerm_subnet.subnet-lan.id
}

output "mgmt-nic-name" {
  description = "The ID of the management network interface."
  value       = azurerm_network_interface.mgmt-nic.name
}

output "wan-nic-name" {
  description = "The ID of the WAN network interface."
  value       = azurerm_network_interface.wan-nic.name
}

output "lan-nic-name" {
  description = "The ID of the LAN network interface."
  value       = azurerm_network_interface.lan-nic.name
}
