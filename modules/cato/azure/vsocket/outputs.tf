# module.vnet outputs
output "resource_group_name" {
  description = "The name of the Azure resource group."
  value       = module.vnet.resource_group_name
}

output "resource_group_location" {
  description = "The location of the Azure resource group."
  value       = module.vnet.resource_group_location
}

output "mgmt-nic-id" {
  description = "The ID of the management network interface."
  value       = module.vnet.mgmt-nic-id
}

output "wan-nic-id" {
  description = "The ID of the WAN network interface."
  value       = module.vnet.wan-nic-id
}

output "lan-nic-id" {
  description = "The ID of the LAN network interface."
  value       = module.vnet.lan-nic-id
}

output "lan_subnet_id" {
  description = "The ID of the LAN subnet."
  value       = module.vnet.lan_subnet_id
}

