variable "vpc_id" {
  description = "The VPC ID where the VPN gateway will be attached"
  type        = string
  default     = null
}

variable "native_network_range" {
  description = "Native network range for the IPSec site (replace with the desired network range)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "bgp_asn" {
  description = "BGP ASN for the AWS customer gateway (Amazon default is 65000, but it can be changed)"
  type        = number
  default     = 65000
}

variable "cgw_ip" {
  description = "Public IP address for the AWS customer gateway (replace with your actual IP)"
  type        = string
}

variable "site_name" {
  description = "Name of the IPSec site in Cato (replace with the desired site name)"
  type        = string
  default     = "AWS-Cato-IPSec-Site"
}

variable "site_type" {
  description = "The type of the site"
  type        = string
  validation {
    condition     = contains(["DATACENTER", "BRANCH", "CLOUD_DC", "HEADQUARTERS"], var.site_type)
    error_message = "The site_type variable must be one of 'DATACENTER','BRANCH','CLOUD_DC','HEADQUARTERS'."
  }
  default = "CLOUD_DC"
}

variable "site_description" {
  description = "Description of the IPSec site in Cato (replace with the desired description)"
  type        = string
  default     = "AWS Cato IPSec Site us-east-1"
}

variable "primary_private_cato_ip" {
  description = "Private IP address of the Cato side for the primary tunnel (replace with the desired value)"
  type        = string
  default     = "169.1.1.2"
}

variable "primary_private_site_ip" {
  description = "Private IP address of the site side for the primary tunnel (replace with the desired value)"
  type        = string
  default     = "169.1.1.3"
}

variable "primary_public_cato_ip_id" {
  description = "Public IP address ID of the Cato side for the primary tunnel (replace with the desired value)"
  type        = string
}

variable "secondary_private_cato_ip" {
  description = "Private IP address of the Cato side for the secondary tunnel (replace with the desired value)"
  type        = string
  default     = "169.2.1.2"
}

variable "secondary_private_site_ip" {
  description = "Private IP address of the site side for the secondary tunnel (replace with the desired value)"
  type        = string
  default     = "169.2.1.3"
}

variable "secondary_public_cato_ip_id" {
  description = "Public IP address ID of the Cato side for the secondary tunnel (replace with the desired value)"
  type        = string
}

variable "downstream_bw" {
  description = "Downstream bandwidth in Mbps for the IPSec tunnel in Cato (replace with the desired value)"
  type        = number
  default     = 100
}

variable "upstream_bw" {
  description = "Upstream bandwidth in Mbps for the IPSec tunnel in Cato (replace with the desired value)"
  type        = number
  default     = 100
}

variable "site_location" {
  description = "Location details for the IPSec site"
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = "New York City"
    country_code = "US"
    state_code   = "US-NY"
    timezone     = "America/New_York"
  }
}