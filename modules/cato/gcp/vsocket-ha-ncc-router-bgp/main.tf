# ------------------------------------------------------------------------------
# Example: Cato vSocket GCP HA with NCC + Cloud Router + BGP
# ------------------------------------------------------------------------------
# Same as the vsocket-ha-ncc example, but also enables a Cloud Router in the LAN
# VPC with BGP peering to the vSocket(s) via the NCC Router Appliance pattern.
# Routes that vSocket advertises back via BGP propagate through the Router
# Appliance spoke into the NCC hub, steering client traffic through the security
# VPC for SASE inspection.
#
# Uses a "bgp" suffix on names / different IP ranges (10.4.x) so this can
# coexist alongside the plain NCC example in the same GCP project.
# ------------------------------------------------------------------------------

provider "google" {
  project = var.security_project_id
  region  = var.region
}

provider "cato" {
  baseurl    = var.baseurl
  token      = var.token
  account_id = var.account_id
}

module "vsocket_gcp_ha_ncc_bgp" {
  source = "../../../../../terraform-cato-vsocket-gcp-ha-ncc-mesh"

  token      = var.token
  account_id = var.account_id
  baseurl    = var.baseurl

  site_name        = var.site_name
  site_description = var.site_description
  site_location    = var.site_location
  site_type        = var.site_type

  region       = var.region
  primary_zone = var.primary_zone
  # secondary_zone = var.secondary_zone
  ha = var.ha

  subnet_mgmt_cidr = var.subnet_mgmt_cidr
  subnet_wan_cidr  = var.subnet_wan_cidr
  subnet_lan_cidr  = var.subnet_lan_cidr

  mgmt_network_ip_primary = var.mgmt_network_ip_primary
  # mgmt_network_ip_secondary = var.mgmt_network_ip_secondary
  wan_network_ip_primary = var.wan_network_ip_primary
  # wan_network_ip_secondary  = var.wan_network_ip_secondary
  lan_network_ip_primary = var.lan_network_ip_primary
  # lan_network_ip_secondary  = var.lan_network_ip_secondary
  # load_balancer_ip          = var.load_balancer_ip

  public_ip_mgmt = var.public_ip_mgmt
  public_ip_wan  = var.public_ip_wan

  create_firewall_rule   = var.create_firewall_rule
  lan_firewall_rule_name = var.lan_firewall_rule_name
  labels                 = var.labels
  tags                   = var.tags

  license_id                      = var.license_id
  license_bw                      = var.license_bw
  routed_networks                 = var.routed_networks
  enable_static_range_translation = var.enable_static_range_translation
  upstream_bandwidth              = var.upstream_bandwidth
  downstream_bandwidth            = var.downstream_bandwidth

  # NCC
  ncc_hub_name        = var.ncc_hub_name
  ncc_spoke_isolation = var.ncc_spoke_isolation
  ncc_client_spokes = {
    "web-tier" = {
      project_id      = var.web_tier_project_id
      vpc_network_uri = "https://www.googleapis.com/compute/v1/projects/${var.web_tier_project_id}/global/networks/${var.web_vpc_name}"
      export_ranges   = var.web_tier_export_ranges
    }
    "app-tier" = {
      project_id      = var.app_tier_project_id
      vpc_network_uri = "https://www.googleapis.com/compute/v1/projects/${var.app_tier_project_id}/global/networks/${var.app_vpc_name}"
      export_ranges   = var.app_tier_export_ranges
    }
  }

  # Cloud Router + BGP (GCP side)
  enable_cloud_router                   = var.enable_cloud_router
  cloud_router_name                     = var.cloud_router_name
  cloud_router_asn                      = var.cloud_router_asn
  cloud_router_advertised_ip_ranges     = var.cloud_router_advertised_ip_ranges
  enable_bgp                            = var.enable_bgp
  cato_bgp_asn                          = var.cato_bgp_asn
  cloud_router_bgp_interface_ip_primary = var.cloud_router_bgp_interface_ip_primary
  # cloud_router_bgp_interface_ip_secondary = var.cloud_router_bgp_interface_ip_secondary
  advertised_route_priority = var.advertised_route_priority
  enable_bfd                = var.enable_bfd
  bfd_min_transmit_interval = var.bfd_min_transmit_interval
  bfd_min_receive_interval  = var.bfd_min_receive_interval
  bfd_multiplier            = var.bfd_multiplier
  create_bgp_firewall_rule  = var.create_bgp_firewall_rule

  # Cato BGP peer (Cato side — auto-configured via Cato API)
  create_cato_bgp_peer                  = var.create_cato_bgp_peer
  cato_bgp_peer_default_action          = var.cato_bgp_peer_default_action
  cato_bgp_peer_advertise_default_route = var.cato_bgp_peer_advertise_default_route
  cato_bgp_peer_advertise_all_routes    = var.cato_bgp_peer_advertise_all_routes
  cato_bgp_peer_summary_routes          = var.cato_bgp_peer_summary_routes
  cato_bgp_peer_metric                  = var.cato_bgp_peer_metric
  enable_cato_bfd                       = var.enable_cato_bfd
}
