variable "baseurl" {
  description = "Cato API base URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "token" {
  description = "Cato API token"
  type        = string
}

variable "account_id" {
  description = "Cato account ID"
  type        = number
}

# Azure Variables
variable "az_location" {
  type        = string
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "cato-ipsec-vnet"
}

variable "gateway_subnet_name" {
  description = "The name of the gateway subnet"
  type        = string
  default     = "gateway-subnet"
}

variable "vpn_gateway_name" {
  description = "The name of the VPN gateway"
  type        = string
  default     = "azure-vpn-gateway"
}

variable "local_network_gateway_name" {
  description = "The name of the local network gateway"
  type        = string
  default     = "cato-local-network-gateway"
}

variable "primary_cato_pop_ip" {
  description = "The IP address of the primary Cato POP"
  type        = string
}

variable "secondary_cato_pop_ip" {
  description = "The IP address of the secondary Cato POP"
  type        = string
}

# Cato Variables
variable "site_name" {
  description = "Name of the IPSec site"
  type        = string
  default     = "Azure-Cato-IPSec-Site"
}

variable "site_description" {
  description = "Description of the IPSec site"
  type        = string
  default     = "Azure Cato IPSec Site"
}

variable "native_network_range" {
  description = "Native network range for the IPSec site"
  type        = string
  default     = "10.50.0.0/16"
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

variable "primary_private_cato_ip" {
  description = "Private IP address of the Cato side for the primary tunnel"
  type        = string
  default     = "169.1.1.1"
}

variable "primary_private_site_ip" {
  description = "Private IP address of the site side for the primary tunnel"
  type        = string
  default     = "169.1.1.2"
}

variable "primary_destination_type" {
  description = "The destination type of the IPsec tunnel"
  type        = string
  default     = null
}

variable "primary_pop_location_id" {
  description = "Primary tunnel POP location ID"
  type        = string
  default     = null
}

variable "secondary_private_cato_ip" {
  description = "Private IP address of the Cato side for the secondary tunnel"
  type        = string
  default     = "169.2.1.1"
}

variable "secondary_private_site_ip" {
  description = "Private IP address of the site side for the secondary tunnel"
  type        = string
  default     = "169.2.1.2"
}

variable "secondary_destination_type" {
  description = "The destination type of the IPsec tunnel"
  type        = string
  default     = null
}

variable "secondary_pop_location_id" {
  description = "Secondary tunnel POP location ID"
  type        = string
  default     = null
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
