# module.ipsec-azure outputs
output "availability_set_name" {
  description = "The name of the availability set"
  value       = module.vnet.availability_set_name
}

output "availability_set_id" {
  description = "The ID of the availability set"
  value       = module.vnet.availability_set_id
}

output "vnet_name" {
  description = "The name of the virtual network (VNet)"
  value       = module.vnet.vnet_name
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = module.vnet.subnet_name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.vnet.subnet_id
}

output "subnet_address_prefixes" {
  description = "The address prefixes associated with the subnet"
  value       = module.vnet.subnet_address_prefixes
}

output "vpn_gateway_id" {
  description = "The ID of the VPN Gateway"
  value       = module.ipsec-azure.vpn_gateway_id
}

# output "vpn_gateway_public_ip" {
#   description = "The public IP address of the VPN Gateway"
#   value       = module.ipsec-azure.vpn_gateway_public_ip
# }

# output "site_id" {
#   description = "ID of the created Cato IPSec site"
#   value       = module.ipsec-azure.site_id
# }

output "cato_license_site" {
  description = "Cato site license"
  value       = module.ipsec-azure.cato_license_site
}