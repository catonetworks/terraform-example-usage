variable "region" {
  description = "AWS Region"
  type        = string
}

variable "account_id" {
  description = "Cato Networks Account ID"
  type        = string
}

variable "token" {
  description = "Cato Networks API Token"
  type        = string
}

variable "key_pair" {
  description = "Name of the EC2 Key Pair to use for SSH access"
  type        = string
}

variable "native_network_range" {
  description = "CIDR block for native subnet inside the vSocket"
  type        = string
  default     = "10.7.0.0/16"
}

variable "site_name" {
  description = "Name for the Cato site"
  type        = string
  default     = "AWS-Cato-IPSEC-TGW-Site"
}

variable "site_description" {
  description = "Description of the Cato site"
  type        = string
  default     = "AWS Cato IPSEC TGW Site"
}

variable "site_location" {
  description = "Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly."
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = null
    country_code = null
    state_code   = null ## Optional - for countries with states
    timezone     = null
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    cato_site_type = "AWS-Cato-vSocket-IPSEC-Site"
    built_with     = "terraform"
    git_repo       = "https://github.com/catonetworks/terraform-example-usage"
  }
}

variable "amazon_side_asn" {
  description = "Amazon side ASN for the Transit Gateway"
  type        = number
  default     = null
}

variable "enable_default_route_table_association" {
  description = "Enable association with default TGW route table"
  type        = bool
  default     = null
}

variable "enable_default_route_table_propagation" {
  description = "Enable propagation with default TGW route table"
  type        = bool
  default     = null
}

variable "enable_auto_accept_shared_attachments" {
  description = "Auto accept shared attachments"
  type        = bool
  default     = null
}

variable "enable_multicast_support" {
  description = "Enable multicast support"
  type        = bool
  default     = null
}

variable "enable_vpn_ecmp_support" {
  description = "Enable ECMP for VPN"
  type        = bool
  default     = null
}

variable "enable_dns_support" {
  description = "Enable DNS support"
  type        = bool
  default     = null
}

variable "transit_gateway_cidr_blocks" {
  description = "Optional CIDR blocks for the TGW"
  type        = list(string)
  default     = null
}

variable "enable_sg_referencing_support" {
  description = "Enable Security Group referencing support"
  type        = bool
  default     = null
}

variable "share_tgw" {
  description = "Share TGW with other accounts"
  type        = bool
  default     = null
}

variable "build_aws_ipsec_tgw_test_env" {
  description = "Build Test Environment for TGW"
  type        = bool
  default     = false
}

variable "external_testing_range" {
  description = "IP Address for Remote Access to Externally Faced Servers"
  default     = null
}

variable "cato_bgp_asn" {
  description = "Cato BGP ASN - Defaults to 64515"
  default     = 64515
}

variable "cato_primary_gateway_ip_address" {
  description = "Cato Primary Gateway IP Address from Available Allocated IPs"
}

variable "cato_secondary_gateway_ip_address" {
  description = "Cato Secondary Gateway IP Address from Available Allocated IPs"
}

variable "primary_vpn_tunnel1_inside_cidr" {
  description = "Primary VPN, Tunnel 1 Inside CIDR"
  type        = string
  default     = "169.254.100.0/30"
}

variable "secondary_vpn_tunnel1_inside_cidr" {
  description = "Primary VPN, Tunnel 2 Inside CIDR"
  type        = string
  default     = "169.254.200.0/30"
}

variable "primary_vpn_tunnel2_inside_cidr" {
  description = "Primary VPN, Tunnel 1 Inside CIDR"
  type        = string
  default     = null
}

variable "secondary_vpn_tunnel2_inside_cidr" {
  description = "Primary VPN, Tunnel 2 Inside CIDR"
  type        = string
  default     = null
}

variable "primary_private_cato_ip" {
  description = "Private IP address of the Cato side for the primary tunnel"
  type        = string
  default     = "169.254.101.2"
}

variable "primary_private_site_ip" {
  description = "Private IP address of the site side for the primary tunnel"
  type        = string
  default     = "169.254.101.1"
}

variable "secondary_private_cato_ip" {
  description = "Private IP address of the Cato side for the secondary tunnel"
  type        = string
  default     = "169.254.201.2"
}

variable "secondary_private_site_ip" {
  description = "Private IP address of the site side for the secondary tunnel"
  type        = string
  default     = "169.254.201.1"
}

variable "downstream_bw" {
  description = "Downstream bandwidth in Mbps"
  type        = number
  default     = 100
}

variable "upstream_bw" {
  description = "Upstream bandwidth in Mbps"
  type        = number
  default     = 100
}