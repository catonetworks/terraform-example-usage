# ------------------------------------------------------------------------------
# Module source (point to terraform-cato-vsocket-gcp-ha-ncc repo)
# ------------------------------------------------------------------------------
variable "vsocket_ha_ncc_module_source" {
  description = "Path or registry source for the terraform-cato-vsocket-gcp-ha-ncc-mesh module."
  type        = string
  default     = "../../../../../terraform-cato-vsocket-gcp-ha-ncc-mesh"
}

# ------------------------------------------------------------------------------
# Cato API
# ------------------------------------------------------------------------------
variable "token" {
  description = "Cato Networks API token."
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "Cato Networks account ID."
  type        = number
  default     = null
}

variable "baseurl" {
  description = "Cato Networks API base URL."
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

# ------------------------------------------------------------------------------
# Site — "bgp" suffix so both examples can coexist
# ------------------------------------------------------------------------------
variable "site_name" {
  description = "vSocket site name (used for Cato and GCP resource naming)."
  type        = string
  default     = "security-bgp"
}

variable "site_description" {
  description = "vSocket site description."
  type        = string
  default     = "Security project vSocket HA with NCC + Cloud Router + BGP"
}

variable "site_location" {
  description = "Site location (null = auto from region)."
  type = object({
    city         = optional(string)
    country_code = optional(string)
    state_code   = optional(string)
    timezone     = optional(string)
  })
  default = {
    city         = null
    country_code = null
    state_code   = null
    timezone     = null
  }
}

variable "site_type" {
  type    = string
  default = "CLOUD_DC"
}

# ------------------------------------------------------------------------------
# GCP Region / Zones (Security project)
# ------------------------------------------------------------------------------
variable "region" {
  description = "GCP region for security project (e.g. us-central1)."
  type        = string
}

variable "security_project_id" {
  description = "GCP project ID of the security project (where vSocket and NCC hub run). Used for load_balancer_self_link output."
  type        = string
}

variable "primary_zone" {
  description = "GCP zone for primary vSocket. Required for BGP (Router Appliance VM reference)."
  type        = string
}

variable "secondary_zone" {
  description = "GCP zone for secondary vSocket. Only used in HA mode."
  type        = string
  default     = null
}

variable "ha" {
  description = "Deploy vSocket in HA mode (primary+secondary). Set false for non-HA example."
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# Security VPC — uses 10.4.x range so it doesn't clash with the plain NCC
# example (10.3.x) when both run in the same project.
# ------------------------------------------------------------------------------
variable "subnet_mgmt_cidr" {
  type    = string
  default = "10.4.1.0/24"
}

variable "subnet_wan_cidr" {
  type    = string
  default = "10.4.2.8/29"
}

variable "subnet_lan_cidr" {
  type    = string
  default = "10.4.3.0/24"
}

variable "mgmt_network_ip_primary" {
  type    = string
  default = "10.4.1.4"
}

variable "mgmt_network_ip_secondary" {
  type    = string
  default = "10.4.1.5"
}

variable "wan_network_ip_primary" {
  type    = string
  default = "10.4.2.10"
}

variable "wan_network_ip_secondary" {
  type    = string
  default = "10.4.2.11"
}

variable "lan_network_ip_primary" {
  type    = string
  default = "10.4.3.4"
}

variable "lan_network_ip_secondary" {
  type    = string
  default = "10.4.3.5"
}

variable "load_balancer_ip" {
  type    = string
  default = "10.4.3.6"
}

variable "public_ip_mgmt" {
  type    = bool
  default = true
}
variable "public_ip_wan" {
  type    = bool
  default = true
}

variable "create_firewall_rule" {
  type    = bool
  default = true
}
variable "lan_firewall_rule_name" {
  type    = string
  default = "allow-private-ranges-traffic-in-lan-subnet-bgp-fw-rule"
}
variable "labels" {
  type    = map(string)
  default = {}
}
variable "tags" {
  type    = list(string)
  default = []
}

variable "license_id" {
  type    = string
  default = null
}
variable "license_bw" {
  type    = string
  default = null
}
variable "routed_networks" {
  type    = map(any)
  default = {}
}
variable "enable_static_range_translation" {
  type    = string
  default = false
}
variable "upstream_bandwidth" {
  type    = string
  default = "1000"
}
variable "downstream_bandwidth" {
  type    = string
  default = "1000"
}

# ------------------------------------------------------------------------------
# NCC — Client projects
# ------------------------------------------------------------------------------
variable "web_tier_project_id" {
  description = "GCP project ID for Host Project / web-tier."
  type        = string
}

variable "web_vpc_name" {
  description = "Name of the VPC in web-tier."
  type        = string
  default     = "web-vpc-1"
}

variable "web_tier_export_ranges" {
  description = "CIDR ranges to export from web-tier VPC."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "app_tier_project_id" {
  description = "GCP project ID for Host Project / app-tier."
  type        = string
}

variable "app_vpc_name" {
  description = "Name of the VPC in app-tier."
  type        = string
  default     = "app-vpc-1"
}

variable "app_tier_export_ranges" {
  description = "CIDR ranges to export from app-tier VPC."
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "ncc_hub_name" {
  type    = string
  default = null
}

variable "ncc_spoke_isolation" {
  description = "Switch hub to STAR preset topology (center/edge groups). Default is MESH with BGP route injection."
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# Cloud Router + BGP
# ------------------------------------------------------------------------------
variable "enable_cloud_router" {
  description = "Create a Cloud Router in the LAN VPC."
  type        = bool
  default     = true
}

variable "cloud_router_name" {
  description = "Name of the Cloud Router. Defaults to '{site_name}-lan-router'."
  type        = string
  default     = null
}

variable "cloud_router_asn" {
  description = "Cloud Router BGP ASN."
  type        = number
  default     = 64520
}

variable "cloud_router_advertised_ip_ranges" {
  description = "IP ranges for the Cloud Router to advertise to BGP peers."
  type = list(object({
    range       = string
    description = optional(string, "")
  }))
  default = []
}

variable "enable_bgp" {
  description = "Enable BGP peering with vSocket via NCC Router Appliance."
  type        = bool
  default     = true
}

variable "cato_bgp_asn" {
  description = "Cato vSocket BGP ASN."
  type        = number
  default     = 64515
}

variable "cloud_router_bgp_interface_ip_primary" {
  description = "Private IP for the Cloud Router primary BGP interface (must be in LAN subnet)."
  type        = string
  default     = "10.4.3.10"
}

variable "cloud_router_bgp_interface_ip_secondary" {
  description = "Private IP for the Cloud Router secondary BGP interface (HA). Set to null to disable."
  type        = string
  default     = "10.4.3.11"
}

variable "advertised_route_priority" {
  description = "BGP advertised route priority (lower = preferred). Secondary uses +100."
  type        = number
  default     = 100
}

variable "enable_bfd" {
  description = "Enable BFD for faster failure detection."
  type        = bool
  default     = true
}

variable "bfd_min_transmit_interval" {
  description = "BFD minimum transmit interval in milliseconds."
  type        = number
  default     = 1000
}

variable "bfd_min_receive_interval" {
  description = "BFD minimum receive interval in milliseconds."
  type        = number
  default     = 1000
}

variable "bfd_multiplier" {
  description = "BFD detection multiplier."
  type        = number
  default     = 5
}

variable "create_bgp_firewall_rule" {
  description = "Create firewall rules for BGP (TCP/179) and BFD (UDP/3784-3785) traffic."
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# Cato BGP peer (auto-configured via Cato API)
# ------------------------------------------------------------------------------
variable "create_cato_bgp_peer" {
  description = "Create cato_bgp_peer resources for automatic Cato-side BGP configuration."
  type        = bool
  default     = true
}

variable "cato_bgp_peer_default_action" {
  description = "Default action for routes not matching filters (ACCEPT or DROP)."
  type        = string
  default     = "ACCEPT"
}

variable "cato_bgp_peer_advertise_default_route" {
  description = "Advertise default route (0.0.0.0/0) from vSocket to Cloud Router for traffic inspection."
  type        = bool
  default     = true
}

variable "cato_bgp_peer_advertise_all_routes" {
  description = "Advertise all Cato routes to the Cloud Router."
  type        = bool
  default     = false
}

variable "cato_bgp_peer_summary_routes" {
  description = "Summary routes to advertise from vSocket to Cloud Router."
  type = list(object({
    route = string
    community = optional(list(object({
      from = number
      to   = number
    })), [])
  }))
  default = []
}

variable "cato_bgp_peer_metric" {
  description = "Route preference metric for the Cato BGP peer (lower = preferred)."
  type        = number
  default     = 150
}

variable "enable_cato_bfd" {
  description = "Enable BFD settings on cato_bgp_peer resources (leave false for CLOUD_DC sites)."
  type        = bool
  default     = false
}
