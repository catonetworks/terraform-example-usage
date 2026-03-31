# ------------------------------------------------------------------------------
# Module source (point to terraform-cato-vsocket-gcp-ha-ncc repo)
# ------------------------------------------------------------------------------
variable "vsocket_ha_ncc_module_source" {
  description = "Path or registry source for the terraform-cato-vsocket-gcp-ha-ncc module."
  type        = string
  default     = "../../../../../terraform-cato-vsocket-gcp-ha-ncc"
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
# Site
# ------------------------------------------------------------------------------
variable "site_name" {
  description = "vSocket site name (used for Cato and GCP resource naming)."
  type        = string
  default     = "security"
}

variable "site_description" {
  description = "vSocket site description."
  type        = string
  default     = "Security project vSocket HA with NCC"
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
  type    = string
  default = null
}

variable "secondary_zone" {
  type    = string
  default = null
}

# ------------------------------------------------------------------------------
# Security VPC — diagram: subnet-security-lan 10.3.2.0/29, subnet-security-wan 10.3.2.8/29
# We use 10.3.1.0/24 mgmt, 10.3.2.8/29 wan, 10.3.3.0/24 lan (room for LB + 2 sockets)
# ------------------------------------------------------------------------------
variable "subnet_mgmt_cidr" {
  type    = string
  default = "10.3.1.0/24"
}

variable "subnet_wan_cidr" {
  type    = string
  default = "10.3.2.8/29"
}

variable "subnet_lan_cidr" {
  type    = string
  default = "10.3.3.0/24"
}

variable "mgmt_network_ip_primary" {
  type    = string
  default = "10.3.1.4"
}

variable "mgmt_network_ip_secondary" {
  type    = string
  default = "10.3.1.5"
}

variable "wan_network_ip_primary" {
  type    = string
  default = "10.3.2.10"
}

variable "wan_network_ip_secondary" {
  type    = string
  default = "10.3.2.11"
}

variable "lan_network_ip_primary" {
  type    = string
  default = "10.3.3.4"
}

variable "lan_network_ip_secondary" {
  type    = string
  default = "10.3.3.5"
}

variable "load_balancer_ip" {
  type    = string
  default = "10.3.3.6"
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
  default = "allow-private-ranges-traffic-in-lan-subnet-fw-rule"
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
# NCC — Client projects (Host Project web-tier and app-tier from diagram)
# Client must create these projects and VPCs before running this example.
# ------------------------------------------------------------------------------
variable "web_tier_project_id" {
  description = "GCP project ID for Host Project / web-tier (must exist and contain web-vpc-1)."
  type        = string
}

variable "web_vpc_name" {
  description = "Name of the Shared VPC in web-tier (e.g. web-vpc-1)."
  type        = string
  default     = "web-vpc-1"
}

variable "web_tier_export_ranges" {
  description = "CIDR ranges to export from web-tier VPC (diagram: 10.1.0.0/20 prod, 10.1.16.0/20 dev, 10.1.32.0/20 test)."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "app_tier_project_id" {
  description = "GCP project ID for Host Project / app-tier (must exist and contain app-vpc-1)."
  type        = string
}

variable "app_vpc_name" {
  description = "Name of the Shared VPC in app-tier (e.g. app-vpc-1)."
  type        = string
  default     = "app-vpc-1"
}

variable "app_tier_export_ranges" {
  description = "CIDR ranges to export from app-tier VPC (diagram: 10.2.0.0/20, 10.2.16.0/20, 10.2.32.0/20)."
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "ncc_hub_name" {
  type    = string
  default = null
}
