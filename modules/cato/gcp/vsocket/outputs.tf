# MGMT Network Outputs
output "vpc_mgmt_name" {
  description = "Management VPC name"
  value       = module.vpc.vpc_mgmt_name
}

output "vpc_mgmt_self_link" {
  description = "Self-link for the Management VPC"
  value       = module.vpc.vpc_mgmt_self_link
}

output "subnet_mgmt_name" {
  description = "Management Subnet name"
  value       = module.vpc.subnet_mgmt_name
}

output "subnet_mgmt_self_link" {
  description = "Self-link for the Management Subnet"
  value       = module.vpc.subnet_mgmt_self_link
}

output "subnet_mgmt_cidr" {
  description = "CIDR range for the Management Subnet"
  value       = module.vpc.subnet_mgmt_cidr
}

output "ip_mgmt_address" {
  description = "Management Public IP Address"
  value       = module.vpc.ip_mgmt_address
}

output "ip_mgmt_self_link" {
  description = "Self-link for the Management Public IP"
  value       = module.vpc.ip_mgmt_self_link
}

# WAN Network Outputs
output "vpc_wan_name" {
  description = "WAN VPC name"
  value       = module.vpc.vpc_wan_name
}

output "vpc_wan_self_link" {
  description = "Self-link for the WAN VPC"
  value       = module.vpc.vpc_wan_self_link
}

output "subnet_wan_name" {
  description = "WAN Subnet name"
  value       = module.vpc.subnet_wan_name
}

output "subnet_wan_self_link" {
  description = "Self-link for the WAN Subnet"
  value       = module.vpc.subnet_wan_self_link
}

output "subnet_wan_cidr" {
  description = "CIDR range for the WAN Subnet"
  value       = module.vpc.subnet_wan_cidr
}

output "ip_wan_address" {
  description = "WAN Public IP Address"
  value       = module.vpc.ip_wan_address
}

output "ip_wan_self_link" {
  description = "Self-link for the WAN Public IP"
  value       = module.vpc.ip_wan_self_link
}

# LAN Network Outputs
output "vpc_lan_name" {
  description = "LAN VPC name"
  value       = module.vpc.vpc_lan_name
}

output "vpc_lan_self_link" {
  description = "Self-link for the LAN VPC"
  value       = module.vpc.vpc_lan_self_link
}

output "subnet_lan_name" {
  description = "LAN Subnet name"
  value       = module.vpc.subnet_lan_name
}

output "subnet_lan_self_link" {
  description = "Self-link for the LAN Subnet"
  value       = module.vpc.subnet_lan_self_link
}

output "subnet_lan_cidr" {
  description = "CIDR range for the LAN Subnet"
  value       = module.vpc.subnet_lan_cidr
}

output "ip_lan_address" {
  description = "LAN Internal IP Address"
  value       = module.vpc.ip_lan_address
}

output "ip_lan_self_link" {
  description = "Self-link for the LAN Internal IP"
  value       = module.vpc.ip_lan_self_link
}