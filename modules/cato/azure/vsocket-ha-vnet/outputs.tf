# module.vsocket-azure-ha-vnet outputs
output "resource_group_name" {
  description = "The name of the Azure Resource Group used for deployment."
  value       = module.vsocket-azure-ha-vnet.resource_group_name
}

output "mgmt_nic_name_primary" {
  description = "The name of the primary management network interface."
  value       = module.vsocket-azure-ha-vnet.mgmt_nic_name_primary
}

output "wan_nic_name_primary" {
  description = "The name of the primary WAN network interface."
  value       = module.vsocket-azure-ha-vnet.wan_nic_name_primary
}

output "lan_nic_name_primary" {
  description = "The name of the primary LAN network interface."
  value       = module.vsocket-azure-ha-vnet.lan_nic_name_primary
}

output "mgmt_nic_name_secondary" {
  description = "The name of the secondary management network interface for HA."
  value       = module.vsocket-azure-ha-vnet.mgmt_nic_name_secondary
}

output "wan_nic_name_secondary" {
  description = "The name of the secondary WAN network interface for HA."
  value       = module.vsocket-azure-ha-vnet.wan_nic_name_secondary
}

output "lan_nic_name_secondary" {
  description = "The name of the secondary LAN network interface for HA."
  value       = module.vsocket-azure-ha-vnet.lan_nic_name_secondary
}

output "lan_subnet_id" {
  description = "The ID of the LAN subnet within the virtual network."
  value       = module.vsocket-azure-ha-vnet.lan_subnet_id
}

output "vnet_name" {
  description = "The name of the Azure Virtual Network used by the deployment."
  value       = module.vsocket-azure-ha-vnet.vnet_name
}

output "lan_subnet_name" {
  description = "The name of the LAN subnet within the virtual network."
  value       = module.vsocket-azure-ha-vnet.lan_subnet_name
}

output "cato_site_id" {
  description = "ID of the Cato Socket Site"
  value       = module.vsocket-azure-ha-vnet.cato_site_id
}

output "cato_site_name" {
  description = "Name of the Cato Site"
  value       = module.vsocket-azure-ha-vnet.cato_site_name
}

output "cato_primary_serial" {
  description = "Primary Cato Socket Serial Number"
  value       = module.vsocket-azure-ha-vnet.cato_primary_serial
}

output "cato_secondary_serial" {
  description = "Secondary Cato Socket Serial Number"
  value       = module.vsocket-azure-ha-vnet.cato_secondary_serial
}

output "mgmt_primary_nic_id" {
  description = "ID of the Management Primary Network Interface"
  value       = module.vsocket-azure-ha-vnet.mgmt_primary_nic_id
}

output "wan_primary_nic_id" {
  description = "ID of the WAN Primary Network Interface"
  value       = module.vsocket-azure-ha-vnet.wan_primary_nic_id
}

output "lan_primary_nic_id" {
  description = "ID of the LAN Primary Network Interface"
  value       = module.vsocket-azure-ha-vnet.lan_primary_nic_id
}

output "mgmt_secondary_nic_id" {
  description = "ID of the Management Secondary Network Interface"
  value       = module.vsocket-azure-ha-vnet.mgmt_secondary_nic_id
}

output "wan_secondary_nic_id" {
  description = "ID of the WAN Secondary Network Interface"
  value       = module.vsocket-azure-ha-vnet.wan_secondary_nic_id
}

output "lan_secondary_nic_id" {
  description = "ID of the LAN Secondary Network Interface"
  value       = module.vsocket-azure-ha-vnet.lan_secondary_nic_id
}

output "vsocket_primary_vm_id" {
  description = "ID of the Primary vSocket Virtual Machine"
  value       = module.vsocket-azure-ha-vnet.vsocket_primary_vm_id
}

output "vsocket_primary_vm_name" {
  description = "Name of the Primary vSocket Virtual Machine"
  value       = module.vsocket-azure-ha-vnet.vsocket_primary_vm_name
}

output "vsocket_secondary_vm_id" {
  description = "ID of the Secondary vSocket Virtual Machine"
  value       = module.vsocket-azure-ha-vnet.vsocket_secondary_vm_id
}

output "vsocket_secondary_vm_name" {
  description = "Name of the Secondary vSocket Virtual Machine"
  value       = module.vsocket-azure-ha-vnet.vsocket_secondary_vm_name
}

output "primary_disk_id" {
  description = "ID of the Primary vSocket Managed Disk"
  value       = module.vsocket-azure-ha-vnet.primary_disk_id
}

output "primary_disk_name" {
  description = "Name of the Primary vSocket Managed Disk"
  value       = module.vsocket-azure-ha-vnet.primary_disk_name
}

output "secondary_disk_id" {
  description = "ID of the Secondary vSocket Managed Disk"
  value       = module.vsocket-azure-ha-vnet.secondary_disk_id
}

output "secondary_disk_name" {
  description = "Name of the Secondary vSocket Managed Disk"
  value       = module.vsocket-azure-ha-vnet.secondary_disk_name
}

output "ha_identity_id" {
  description = "ID of the User Assigned Identity for HA"
  value       = module.vsocket-azure-ha-vnet.ha_identity_id
}

output "ha_identity_principal_id" {
  description = "Principal ID of the HA Identity"
  value       = module.vsocket-azure-ha-vnet.ha_identity_principal_id
}

output "primary_nic_role_assignment_id" {
  description = "Role Assignment ID for the Primary NIC"
  value       = module.vsocket-azure-ha-vnet.primary_nic_role_assignment_id
}

output "secondary_nic_role_assignment_id" {
  description = "Role Assignment ID for the Secondary NIC"
  value       = module.vsocket-azure-ha-vnet.secondary_nic_role_assignment_id
}

output "lan_subnet_role_assignment_id" {
  description = "Role Assignment ID for the LAN Subnet"
  value       = module.vsocket-azure-ha-vnet.lan_subnet_role_assignment_id
}

output "lan_secondary_mac_address" {
  description = "MAC Address of the Secondary LAN Interface"
  value       = module.vsocket-azure-ha-vnet.lan_secondary_mac_address
}

# output "vsocket_primary_reboot_status" {
#   description = "Status of the Primary vSocket VM Reboot"
#   value       = module.vsocket-azure-ha-vnet.vsocket_primary_reboot_status
# }

# output "vsocket_secondary_reboot_status" {
#   description = "Status of the Secondary vSocket VM Reboot"
#   value       = module.vsocket-azure-ha-vnet.vsocket_secondary_reboot_status
# }

# output "cato_license_site" {
#   description = "The license site information for the Cato Socket."
#   value       = module.vsocket-azure-ha-vnet.cato_license_site
# }
