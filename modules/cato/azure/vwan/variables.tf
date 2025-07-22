variable "token" {
  description = "The API token for the Cato Management Application."
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "The Account ID for the Cato Management Application."
  type        = string
}

variable "baseurl" {
  description = "The base URL for the Cato API."
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql"
}

variable "hub1_tags" {
  description = "A map of tags to apply to all taggable Azure resources."
  type        = map(string)
  default     = {}
}

variable "hub2_tags" {
  description = "A map of tags to apply to all taggable Azure resources."
  type        = map(string)
  default     = {}
}

variable "primary_cato_pop_ip" {
  description = "The public IP address of the primary Cato PoP. Must match the name of an allocated IP in Cato."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.primary_cato_pop_ip))
    error_message = "The primary_cato_pop_ip value must be a valid IPv4 address."
  }
}

variable "secondary_cato_pop_ip" {
  description = "The public IP address of the secondary Cato PoP. Must match the name of an allocated IP in Cato. If null, a secondary connection will not be configured."
  type        = string
  default     = null
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.secondary_cato_pop_ip))
    error_message = "The primary_cato_pop_ip value must be a valid IPv4 address."
  }
}

variable "hub1_downstream_bw" {
  description = "The downstream bandwidth in Mbps."
  type        = number
  default     = 25
}

variable "hub1_upstream_bw" {
  description = "The upstream bandwidth in Mbps."
  type        = number
  default     = 25
}

variable "hub2_downstream_bw" {
  description = "The downstream bandwidth in Mbps."
  type        = number
  default     = 25
}

variable "hub2_upstream_bw" {
  description = "The upstream bandwidth in Mbps."
  type        = number
  default     = 25
}

variable "hub1_location" {
  description = "The Azure Region in which to deploy Hub1"
  type        = string
}

variable "hub2_location" {
  description = "The Azure Region in which to deploy Hub2"
  type        = string
}

variable "location" {
  description = "The Azure Region for the provider"
  type        = string
}

variable "azure_resource_group_name" {
  description = "The name of the existing Azure Resource Group where the VWAN Hub resides."
  type        = string
  default     = "Azure-Cato-vWAN-Site-Resource-Group"
}

variable "az_virtual_wan_name" {
  description = "The name for the Azure Virtual WAN"
  type        = string
  default     = "Azure-Cato-vWAN-Site-VWAN"
}

variable "az_virtualhub_1_name" {
  description = "The name for Hub 1"
  type        = string
  default     = "Azure-Cato-vWAN-Site-HUB1"
}

variable "az_virtualhub_2_name" {
  description = "The name for Hub 2"
  type        = string
  default     = "Azure-Cato-vWAN-Site-HUB2"
}

variable "az_virtualhub_1_address_prefix" {
  description = "The IP Address Cidr for Hub1"
  type        = string
  default     = "10.55.0.0/17"
}

variable "az_virtualhub_2_address_prefix" {
  description = "The IP Address Cidr for Hub2"
  type        = string
  default     = "10.55.128.0/17"
}

variable "hub1_site_name" {
  description = "The name of the site in the Cato Management Application."
  type        = string
  default     = "Azure-Cato-vWAN-Site_hub1"
}

variable "hub1_site_description" {
  description = "A description for the site in the Cato Management Application."
  type        = string
  default     = "Azure-Cato-vWAN-Site_hub1"
}

variable "hub2_site_name" {
  description = "The name of the site in the Cato Management Application."
  type        = string
  default     = "Azure-Cato-vWAN-Site_hub2"
}

variable "hub2_site_description" {
  description = "A description for the site in the Cato Management Application."
  type        = string
  default     = "Azure-Cato-vWAN-Site_hub2"
}

variable "site_type" {
  description = "The type of the site in Cato (e.g., CLOUD_DC)."
  type        = string
  default     = "CLOUD_DC"
}

variable "native_network_range" {
  description = "The native network range for the site. If null, it will be automatically populated from the Azure Hub's address prefix."
  type        = string
  default     = null
}

variable "cato_asn" {
  description = "Private ASN for Cato Side"
  type        = number
  default     = 65002
}

variable "azure_asn" {
  description = "Private ASN for Azure Side"
  type        = number
  default     = 65515
}

variable "hub1_azure_primary_bgp_ip" {
  description = "Private IP Address for BGP on Azure Side"
  type        = string
  default     = "169.254.21.5"
}

variable "hub1_cato_primary_bgp_ip" {
  description = "Private IP Address for BGP on Cato Side"
  type        = string
  default     = "169.254.21.6"
}

variable "hub1_azure_secondary_bgp_ip" {
  description = "Private IP Address for BGP on Azure Side"
  type        = string
  default     = "169.254.22.5"
}

variable "hub1_cato_secondary_bgp_ip" {
  description = "Private IP Address for BGP on Cato Side"
  type        = string
  default     = "169.254.22.6"
}

variable "hub2_azure_primary_bgp_ip" {
  description = "Private IP Address for BGP on Azure Side"
  type        = string
  default     = "169.254.21.9"
}

variable "hub2_cato_primary_bgp_ip" {
  description = "Private IP Address for BGP on Cato Side"
  type        = string
  default     = "169.254.21.10"
}

variable "hub2_azure_secondary_bgp_ip" {
  description = "Private IP Address for BGP on Azure Side"
  type        = string
  default     = "169.254.22.9"
}

variable "hub2_cato_secondary_bgp_ip" {
  description = "Private IP Address for BGP on Cato Side"
  type        = string
  default     = "169.254.22.10"
}
