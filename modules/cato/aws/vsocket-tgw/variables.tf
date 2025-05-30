variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the vSocket"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "key_pair" {
  description = "Name of the EC2 Key Pair to use for SSH access"
  type        = string
}

variable "vpc_network_range" {
  description = "CIDR block for the new VPC"
  type        = string
  default     = "10.5.0.0/24"
}

variable "native_network_range" {
  description = "CIDR block for native subnet inside the vSocket"
  type        = string
  default     = "10.5.0.0/16"
}

variable "subnet_range_mgmt" {
  description = "CIDR block for the management subnet"
  type        = string
  default     = null
}

variable "subnet_range_wan" {
  description = "CIDR block for the WAN subnet"
  type        = string
  default     = null
}

variable "subnet_range_lan" {
  description = "CIDR block for the LAN subnet"
  type        = string
  default     = null
}

variable "subnet_range_tgw" {
  description = "CIDR block for the TGW subnet"
  type        = string
  default     = null
}

variable "mgmt_eni_ip" {
  description = "Static IP for the management ENI"
  type        = string
  default     = null
}

variable "wan_eni_ip" {
  description = "Static IP for the WAN ENI"
  type        = string
  default     = null
}

variable "lan_eni_ip" {
  description = "Static IP for the LAN ENI"
  type        = string
  default     = null
}

variable "site_name" {
  description = "Name for the Cato site"
  type        = string
  default     = "AWS-Cato-vSocket-TGW-Site"
}

variable "site_description" {
  description = "Description of the Cato site"
  type        = string
  default     = "AWS Cato vSocket TGW Site"
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
    cato_site_type = "AWS-Cato-vSocket-TGW-Site"
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

variable "build_aws_vsocket_tgw_test_env" {
  description = "Build Test Environment for TGW"
  type        = bool
  default     = false
}

variable "external_testing_range" { 
  description = "IP Address for Remote Access to Externally Faced Servers"
  default = null
}