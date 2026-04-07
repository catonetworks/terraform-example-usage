# Pass-through from NCC module (security project + NCC)
output "site_id" { value = module.vsocket_gcp_ha_ncc_bgp.site_id }
output "site_name" { value = module.vsocket_gcp_ha_ncc_bgp.site_name }
output "load_balancer_ip" { value = module.vsocket_gcp_ha_ncc_bgp.load_balancer_ip }
output "load_balancer_name" { value = module.vsocket_gcp_ha_ncc_bgp.load_balancer_name }
output "vpc_lan_name" { value = module.vsocket_gcp_ha_ncc_bgp.vpc_lan_name }
output "vpc_lan_id" { value = module.vsocket_gcp_ha_ncc_bgp.vpc_lan_id }
output "vpc_lan_self_link" { value = module.vsocket_gcp_ha_ncc_bgp.vpc_lan_self_link }
output "ncc_hub_id" { value = module.vsocket_gcp_ha_ncc_bgp.ncc_hub_id }
output "ncc_hub_name" { value = module.vsocket_gcp_ha_ncc_bgp.ncc_hub_name }
output "ncc_security_spoke_id" { value = module.vsocket_gcp_ha_ncc_bgp.ncc_security_spoke_id }
output "ncc_client_spoke_ids" { value = module.vsocket_gcp_ha_ncc_bgp.ncc_client_spoke_ids }
output "ncc_hub_topology" { value = module.vsocket_gcp_ha_ncc_bgp.ncc_hub_topology }
output "ncc_client_group_ids" { value = module.vsocket_gcp_ha_ncc_bgp.ncc_client_group_ids }

output "load_balancer_self_link" {
  description = "Self-link of the Internal Load Balancer in the security project."
  value       = "https://www.googleapis.com/compute/v1/projects/${var.security_project_id}/regions/${var.region}/forwardingRules/${module.vsocket_gcp_ha_ncc_bgp.load_balancer_name}"
}

# Cloud Router + BGP
output "cloud_router_id" { value = module.vsocket_gcp_ha_ncc_bgp.cloud_router_id }
output "cloud_router_name" { value = module.vsocket_gcp_ha_ncc_bgp.cloud_router_name }
output "router_appliance_spoke_id" { value = module.vsocket_gcp_ha_ncc_bgp.router_appliance_spoke_id }
output "bgp_peer_status_command" { value = module.vsocket_gcp_ha_ncc_bgp.bgp_peer_status_command }

# Cato BGP peers
output "cato_bgp_peer_primary_id" { value = module.vsocket_gcp_ha_ncc_bgp.cato_bgp_peer_primary_id }
output "cato_bgp_peer_secondary_id" { value = module.vsocket_gcp_ha_ncc_bgp.cato_bgp_peer_secondary_id }
