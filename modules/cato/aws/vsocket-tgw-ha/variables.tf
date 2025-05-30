variable "token" {
  description = "Cato API token for authentication"
  type        = string
}

variable "account_id" {
  description = "Cato account ID"
  type        = string
}

variable "key_pair" {
  description = "Name of the AWS EC2 key pair"
  type        = string
}

variable "vpc_network_range" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.6.0.0/24"
}

variable "native_network_range" {
  description = "Native network CIDR range for Cato integration"
  type        = string
  default     = "10.6.0.0/16"
}

variable "subnet_range_mgmt_primary" {
  description = "Primary management subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_mgmt_secondary" {
  description = "Secondary management subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_wan_primary" {
  description = "Primary WAN subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_wan_secondary" {
  description = "Secondary WAN subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_lan_primary" {
  description = "Primary LAN subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_lan_secondary" {
  description = "Secondary LAN subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_tgw_primary" {
  description = "Primary TGW subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_range_tgw_secondary" {
  description = "Secondary TGW subnet CIDR"
  type        = string
  default     = null
}

variable "mgmt_eni_primary_ip" {
  description = "Primary management ENI private IP"
  type        = string
  default     = null
}

variable "mgmt_eni_secondary_ip" {
  description = "Secondary management ENI private IP"
  type        = string
  default     = null
}

variable "wan_eni_primary_ip" {
  description = "Primary WAN ENI private IP"
  type        = string
  default     = null
}

variable "wan_eni_secondary_ip" {
  description = "Secondary WAN ENI private IP"
  type        = string
  default     = null
}

variable "lan_eni_primary_ip" {
  description = "Primary LAN ENI private IP"
  type        = string
  default     = null
}

variable "lan_eni_secondary_ip" {
  description = "Secondary LAN ENI private IP"
  type        = string
  default     = null
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "site_name" {
  description = "Name of the Cato site"
  type        = string
  default     = "AWS-Cato-vSocket-TGW-HA-Site"
}

variable "site_description" {
  description = "Description of the Cato site"
  type        = string
  default     = "AWS Cato vSocket TGW HA Site"
}

variable "site_location" {
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = "San Diego"
    country_code = "US"
    state_code   = "US-CA" ## Optional - for countries with states
    timezone     = "America/Los_Angeles"
  }
}
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    cato_site_type = "AWS-Cato-vSocket-TGW-HA-Site"
    built_with     = "terraform"
    git_repo       = "https://github.com/catonetworks/terraform-example-usage"
  }
}

variable "amazon_side_asn" {
  description = "Amazon side ASN for the TGW"
  type        = number
  default     = null
}

variable "enable_default_route_table_association" {
  description = "Enable default route table association"
  type        = bool
  default     = null
}

variable "enable_default_route_table_propagation" {
  description = "Enable default route table propagation"
  type        = bool
  default     = null
}

variable "enable_auto_accept_shared_attachments" {
  description = "Enable auto-accept shared attachments"
  type        = bool
  default     = null
}

variable "enable_multicast_support" {
  description = "Enable multicast support on TGW"
  type        = bool
  default     = null
}

variable "enable_vpn_ecmp_support" {
  description = "Enable VPN Equal Cost Multi-Path support"
  type        = bool
  default     = null
}

variable "enable_dns_support" {
  description = "Enable DNS support on TGW"
  type        = bool
  default     = null
}

variable "transit_gateway_cidr_blocks" {
  description = "CIDR blocks for the Transit Gateway"
  type        = list(string)
  default     = null
}

variable "enable_sg_referencing_support" {
  description = "Enable TGW support for referencing security groups"
  type        = bool
  default     = null
}

variable "share_tgw" {
  description = "Indicates whether the TGW should be shared with other accounts"
  type        = bool
  default     = null
}
variable "build_aws_vsocket_tgw_ha_test_env" {
  description = "Build AWS vSocket tgw ha test env module"
  type        = bool
}

variable "external_testing_range" { 
  description = "IP Address for Remote Access to Externally Faced Servers"
  default = null
}