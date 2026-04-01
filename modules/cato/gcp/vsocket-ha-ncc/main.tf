# ------------------------------------------------------------------------------
# Example: Cato vSocket GCP HA with NCC (Network Connectivity Center)
# ------------------------------------------------------------------------------
# This example invokes the terraform-cato-vsocket-gcp-ha-ncc module to create:
#   - Security project: vSocket HA (two vSockets, Internal LB, LAN/WAN/Mgmt VPCs)
#   - NCC Hub + Security spoke (LAN VPC attached) + Client spokes (web-tier, app-tier)
#   - Policy-based routes so client traffic → vSocket (SASE)
#
# The client must create separately (see README): Host projects (web-tier, app-tier),
# Shared VPCs (web-vpc-1, app-vpc-1) with subnets, custom static routes to Internal LB,
# and optionally service projects + VMs.
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

module "vsocket_gcp_ha_ncc" {
  source = "../../../../../terraform-cato-vsocket-gcp-ha-ncc"

  token      = var.token
  account_id = var.account_id
  baseurl    = var.baseurl

  site_name        = var.site_name
  site_description = var.site_description
  site_location    = var.site_location
  site_type        = var.site_type

  region         = var.region
  primary_zone   = var.primary_zone
  secondary_zone = var.secondary_zone

  # Security VPC (diagram: 10.3.x) — mgmt 10.3.1.0/24, wan 10.3.2.8/29, lan 10.3.3.0/24
  subnet_mgmt_cidr = var.subnet_mgmt_cidr
  subnet_wan_cidr  = var.subnet_wan_cidr
  subnet_lan_cidr  = var.subnet_lan_cidr

  mgmt_network_ip_primary   = var.mgmt_network_ip_primary
  mgmt_network_ip_secondary = var.mgmt_network_ip_secondary
  wan_network_ip_primary    = var.wan_network_ip_primary
  wan_network_ip_secondary  = var.wan_network_ip_secondary
  lan_network_ip_primary    = var.lan_network_ip_primary
  lan_network_ip_secondary  = var.lan_network_ip_secondary
  load_balancer_ip          = var.load_balancer_ip

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

  # NCC: client spokes (Host Project web-tier and app-tier from diagram)
  ncc_hub_name = var.ncc_hub_name
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
}
