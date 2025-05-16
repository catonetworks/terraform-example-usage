## The following attributes are exported:
output "resource_group_name" {
  description = "The name of the Azure resource group."
  value       = azurerm_resource_group.azure-rg.name
}

output "lan_subnet_id" {
  description = "The ID of the LAN subnet."
  value       = azurerm_subnet.subnet-lan.id
}

output "lan_subnet_name" {
  description = "The name of the LAN subnet."
  value       = azurerm_subnet.subnet-lan.name
}

output "vnet_name" {
  description = "The name of the Azure virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "mgmt_nic_name_primary" {
  description = "The name of the primary management network interface."
  value       = azurerm_network_interface.mgmt-nic-primary.name
}

output "wan_nic_name_primary" {
  description = "The name of the primary WAN network interface."
  value       = azurerm_network_interface.wan-nic-primary.name
}

output "lan_nic_name_primary" {
  description = "The name of the primary LAN network interface."
  value       = azurerm_network_interface.lan-nic-primary.name
}

output "mgmt_nic_name_secondary" {
  description = "The name of the secondary management network interface."
  value       = azurerm_network_interface.mgmt-nic-secondary.name
}

output "wan_nic_name_secondary" {
  description = "The name of the secondary WAN network interface."
  value       = azurerm_network_interface.wan-nic-secondary.name
}

output "lan_nic_name_secondary" {
  description = "The name of the secondary LAN network interface."
  value       = azurerm_network_interface.lan-nic-secondary.name
}

