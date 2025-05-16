output "vpc_mgmt_id" {
  value       = google_compute_network.vpc_mgmt.id
  description = "The ID of the management VPC."
}

output "vpc_wan_id" {
  value       = google_compute_network.vpc_wan.id
  description = "The ID of the WAN VPC."
}

output "vpc_lan_id" {
  value       = google_compute_network.vpc_lan.id
  description = "The ID of the LAN VPC."
}

output "subnet_mgmt_id" {
  value       = google_compute_subnetwork.subnet_mgmt.id
  description = "The ID of the management subnet."
}

output "subnet_wan_id" {
  value       = google_compute_subnetwork.subnet_wan.id
  description = "The ID of the WAN subnet."
}

output "subnet_lan_id" {
  value       = google_compute_subnetwork.subnet_lan.id
  description = "The ID of the LAN subnet."
}

# VPC Network Outputs
output "vpc_mgmt_name" {
  description = "Management VPC name"
  value       = google_compute_network.vpc_mgmt.name
}

output "vpc_mgmt_self_link" {
  description = "Self-link for the Management VPC"
  value       = google_compute_network.vpc_mgmt.self_link
}

output "vpc_wan_name" {
  description = "WAN VPC name"
  value       = google_compute_network.vpc_wan.name
}

output "vpc_wan_self_link" {
  description = "Self-link for the WAN VPC"
  value       = google_compute_network.vpc_wan.self_link
}

output "vpc_lan_name" {
  description = "LAN VPC name"
  value       = google_compute_network.vpc_lan.name
}

output "vpc_lan_self_link" {
  description = "Self-link for the LAN VPC"
  value       = google_compute_network.vpc_lan.self_link
}

# Subnet Outputs
output "subnet_mgmt_name" {
  description = "Management Subnet name"
  value       = google_compute_subnetwork.subnet_mgmt.name
}

output "subnet_mgmt_self_link" {
  description = "Self-link for the Management Subnet"
  value       = google_compute_subnetwork.subnet_mgmt.self_link
}

output "subnet_mgmt_cidr" {
  description = "CIDR range for the Management Subnet"
  value       = google_compute_subnetwork.subnet_mgmt.ip_cidr_range
}

output "subnet_wan_name" {
  description = "WAN Subnet name"
  value       = google_compute_subnetwork.subnet_wan.name
}

output "subnet_wan_self_link" {
  description = "Self-link for the WAN Subnet"
  value       = google_compute_subnetwork.subnet_wan.self_link
}

output "subnet_wan_cidr" {
  description = "CIDR range for the WAN Subnet"
  value       = google_compute_subnetwork.subnet_wan.ip_cidr_range
}

output "subnet_lan_name" {
  description = "LAN Subnet name"
  value       = google_compute_subnetwork.subnet_lan.name
}

output "subnet_lan_self_link" {
  description = "Self-link for the LAN Subnet"
  value       = google_compute_subnetwork.subnet_lan.self_link
}

output "subnet_lan_cidr" {
  description = "CIDR range for the LAN Subnet"
  value       = google_compute_subnetwork.subnet_lan.ip_cidr_range
}

# Static IP Outputs
output "ip_mgmt_address" {
  description = "Management Public IP Address"
  value       = var.public_ip_mgmt ? google_compute_address.ip_mgmt[0].address : "No Public IP Assigned"
}

output "ip_mgmt_self_link" {
  description = "Self-link for the Management Public IP"
  value       = var.public_ip_mgmt ? google_compute_address.ip_mgmt[0].self_link : "No Public IP Assigned"
}

output "ip_wan_address" {
  description = "WAN Public IP Address"
  value       = var.public_ip_wan ? google_compute_address.ip_wan[0].address : "No Public IP Assigned"
}

output "ip_wan_self_link" {
  description = "Self-link for the WAN Public IP"
  value       = var.public_ip_wan ? google_compute_address.ip_wan[0].self_link : "No Public IP Assigned"
}

output "ip_lan_address" {
  description = "LAN Internal IP Address"
  value       = google_compute_address.ip_lan.address
}

output "ip_lan_self_link" {
  description = "Self-link for the LAN Internal IP"
  value       = google_compute_address.ip_lan.self_link
}