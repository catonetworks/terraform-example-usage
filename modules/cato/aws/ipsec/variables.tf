variable "vpc_id" {
  description = "The VPC ID where the VPN gateway will be attached"
  type        = string
  default     = null
}

variable "aws_bgp_asn" {
  description = "AWS's BGP Autonomous System Number"
  type        = number
  default     = 65000
}

variable "cato_bgp_asn" {
  description = "Cato's BGP Autonomous System Number"
  type        = number
  default     = 65001
}

variable "native_network_range" {
  description = "Native network range for the IPSec site (replace with the desired network range)"
  type        = string
  default     = "10.0.0.0/16"
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
  default     = "169.254.100.2"
}

variable "primary_private_site_ip" {
  description = "Private IP address of the site side for the primary tunnel (replace with the desired value)"
  type        = string
  default     = "169.254.100.1"
}

variable "primary_public_cato_ip" {
  description = "Public IP address ID of the Cato side for the primary tunnel (replace with the desired value)"
  type        = string
}

variable "secondary_private_cato_ip" {
  description = "Private IP address of the Cato side for the secondary tunnel (replace with the desired value)"
  type        = string
  default     = "169.254.200.2"
}

variable "secondary_private_site_ip" {
  description = "Private IP address of the site side for the secondary tunnel (replace with the desired value)"
  type        = string
  default     = "169.254.200.1"
}

variable "secondary_public_cato_ip" {
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

variable "region" {
  description = "AWS region where resources will be deployed."
  type        = string
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