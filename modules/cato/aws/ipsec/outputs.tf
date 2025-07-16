output "primary_vpn_connection_id" {
  description = "ID of the created AWS VPN connection"
  value       = module.ipsec-aws.primary_vpn_connection_id
}

output "secondary_vpn_connection_id" {
  description = "ID of the created AWS VPN connection"
  value       = module.ipsec-aws.secondary_vpn_connection_id
}

output "primary_tunnel_address" {
  value = module.ipsec-aws.primary_tunnel_address
}

output "secondary_tunnel_address" {
  value = module.ipsec-aws.secondary_tunnel_address
}

output "tunnel1_preshared_key" {
  value     = module.ipsec-aws.tunnel1_preshared_key
  sensitive = true
}

output "tunnel2_preshared_key" {
  value     = module.ipsec-aws.tunnel2_preshared_key
  sensitive = true
}

output "site_id" {
  description = "ID of the created Cato IPSec site"
  value       = module.ipsec-aws.site_id
}

output "cato_license_site" {
  value = module.ipsec-aws.cato_license_site
}

output "vpc_id" {
  description = "ID of the created Cato IPSec site"
  value       = module.ipsec-aws.vpc_id
}
