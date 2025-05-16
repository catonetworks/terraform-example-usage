# module.vsocket-azure-vnet outputs
output "azurerm_virtual_network_id" {
  value = module.vsocket-azure-vnet.azurerm_virtual_network_id
}

output "azurerm_availability_set" {
  value = module.vsocket-azure-vnet.azurerm_availability_set
}

output "lan_sg_id" {
  value = module.vsocket-azure-vnet.lan_sg_id
}

output "mgmt_sg_id" {
  value = module.vsocket-azure-vnet.mgmt_sg_id
}

output "wan_sg_id" {
  value = module.vsocket-azure-vnet.wan_sg_id
}

output "lan_nic_id" {
  value = module.vsocket-azure-vnet.lan_nic_id
}

output "mgmt_nic_id" {
  value = module.vsocket-azure-vnet.mgmt_nic_id
}

output "wan_nic_id" {
  value = module.vsocket-azure-vnet.wan_nic_id
}

output "lan_nic_association_id" {
  value = module.vsocket-azure-vnet.lan_nic_association_id
}

output "mgmt_nic_association_id" {
  value = module.vsocket-azure-vnet.mgmt_nic_association_id
}

output "wan_nic_association_id" {
  value = module.vsocket-azure-vnet.wan_nic_association_id
}

output "mgmt_public_ip_id" {
  value = module.vsocket-azure-vnet.mgmt_public_ip_id
}

output "wan_public_ip_id" {
  value = module.vsocket-azure-vnet.wan_public_ip_id
}

output "resource_group_name" {
  value = module.vsocket-azure-vnet.resource_group_name
}

output "private_rt_id" {
  value = module.vsocket-azure-vnet.private_rt_id
}

output "public_rt_id" {
  value = module.vsocket-azure-vnet.public_rt_id
}

output "lan_route_id" {
  value = module.vsocket-azure-vnet.lan_route_id
}

output "public_route_id" {
  value = module.vsocket-azure-vnet.public_route_id
}

output "azurerm_route_id" {
  value = module.vsocket-azure-vnet.azurerm_route_id
}

output "lan_subnet_id" {
  value = module.vsocket-azure-vnet.lan_subnet_id
}

output "mgmt_subnet_id" {
  value = module.vsocket-azure-vnet.mgmt_subnet_id
}

output "wan_subnet_id" {
  value = module.vsocket-azure-vnet.wan_subnet_id
}

output "lan_rt_association_id" {
  value = module.vsocket-azure-vnet.lan_rt_association_id
}

output "mgmt_rt_association_id" {
  value = module.vsocket-azure-vnet.mgmt_rt_association_id
}

output "wan_rt_association_id" {
  value = module.vsocket-azure-vnet.wan_rt_association_id
}

output "dns_servers_id" {
  value = module.vsocket-azure-vnet.dns_servers_id
}

output "socket_site_id" {
  value = module.vsocket-azure-vnet.socket_site_id
}

output "socket_site_serial" {
  value = module.vsocket-azure-vnet.socket_site_serial
}

output "cato_license_site" {
  value = module.vsocket-azure-vnet.cato_license_site
}