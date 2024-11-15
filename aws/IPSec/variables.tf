# AWS Variables

variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
}

variable "bgp_asn" {
  description = "BGP ASN for the customer gateway"
  type        = number
}

variable "cgw_ip" {
  description = "Public IP address for the customer gateway"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the VPN gateway will be attached"
  type        = string
  default     = null
}

# Cato Variables

variable "baseurl" {
  description = "Cato Networks API URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "cato_token" {
  description = "Cato Networks API Token"
  type        = string
  #sensitive   = true
}

variable "account_id" {
  description = "Cato Networks Account ID"
  type        = string
}

variable "site_name" {
  description = "Name of the IPSec site"
  type        = string
}

variable "site_description" {
  description = "Description of the IPSec site"
  type        = string
}

variable "native_network_range" {
  description = "Native network range for the IPSec site"
  type        = string
}

variable "site_type" {
  description = "The type of the site"
  type        = string
  default     = "CLOUD_DC"
  validation {
    condition     = contains(["DATACENTER", "BRANCH", "CLOUD_DC", "HEADQUARTERS"], var.site_type)
    error_message = "The site_type variable must be one of 'DATACENTER','BRANCH','CLOUD_DC','HEADQUARTERS'."
  }
}

variable "site_location" {
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = "Belmont"
    country_code = "US"
    state_code   = "US-CA" ## Optional - for countries with states
    timezone     = "America/Los_Angeles"
  }
}

variable "primary_private_cato_ip" {
  description = "Private IP address of the Cato side for the primary tunnel"
  type        = string
}

variable "primary_private_site_ip" {
  description = "Private IP address of the site side for the primary tunnel"
  type        = string
}

variable "secondary_private_cato_ip" {
  description = "Private IP address of the Cato side for the secondary tunnel"
  type        = string
}

variable "secondary_private_site_ip" {
  description = "Private IP address of the site side for the secondary tunnel"
  type        = string
}

variable "primary_public_cato_ip_id" {
  description = "Public IP address ID of the Cato side for the primary tunnel"
  type        = string
}

variable "secondary_public_cato_ip_id" {
  description = "Public IP address ID of the Cato side for the secondary tunnel"
  type        = string
}

variable "downstream_bw" {
  description = "Downstream bandwidth in Mbps"
  type        = number
}

variable "upstream_bw" {
  description = "Upstream bandwidth in Mbps"
  type        = number
}
