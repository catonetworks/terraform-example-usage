# Pass-through from NCC module (security project + NCC)
output "site_id"                    { value = module.vsocket_gcp_ha_ncc.site_id }
output "site_name"                  { value = module.vsocket_gcp_ha_ncc.site_name }
output "load_balancer_ip"           { value = module.vsocket_gcp_ha_ncc.load_balancer_ip }
output "load_balancer_name"        { value = module.vsocket_gcp_ha_ncc.load_balancer_name }
output "vpc_lan_name"              { value = module.vsocket_gcp_ha_ncc.vpc_lan_name }
output "vpc_lan_id"                { value = module.vsocket_gcp_ha_ncc.vpc_lan_id }
output "vpc_lan_self_link"         { value = module.vsocket_gcp_ha_ncc.vpc_lan_self_link }
output "ncc_hub_id"                { value = module.vsocket_gcp_ha_ncc.ncc_hub_id }
output "ncc_hub_name"              { value = module.vsocket_gcp_ha_ncc.ncc_hub_name }
output "ncc_security_spoke_id"     { value = module.vsocket_gcp_ha_ncc.ncc_security_spoke_id }
output "ncc_client_spoke_ids"       { value = module.vsocket_gcp_ha_ncc.ncc_client_spoke_ids }

# For client module: Internal LB self-link to use as next-hop in custom static routes (requires security_project_id)
output "load_balancer_self_link" {
  description = "Self-link of the Internal Load Balancer in the security project. Use as next_hop_ilb in custom routes in web-tier and app-tier. Requires security_project_id variable."
  value       = "https://www.googleapis.com/compute/v1/projects/${var.security_project_id}/regions/${var.region}/forwardingRules/${module.vsocket_gcp_ha_ncc.load_balancer_name}"
}
