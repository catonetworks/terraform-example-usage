# ===============================================================================
# Azure vWAN vSocket HA Module Variables
# ===============================================================================

# --- Authentication Variables ---

variable "cato_token" {
  description = "Cato Management API Token."
  type        = string
  sensitive   = true
}

variable "cato_account_id" {
  description = "Your Cato Account ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.cato_account_id)) && length(var.cato_account_id) >= 4 && length(var.cato_account_id) <= 10
    error_message = "Cato Account ID must be a numeric string between 4-10 digits."
  }
}

variable "baseurl" {
  description = "Base URL for the Cato Networks API."
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "azure_subscription_id" {
  description = "The Azure Subscription ID where resources will be deployed."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.azure_subscription_id))
    error_message = "Azure Subscription ID must be a valid GUID format (e.g., 12345678-1234-1234-1234-123456789012)."
  }
}

# --- Global Azure Configuration ---

variable "azure_name_prefix" {
  description = "A prefix to be used for naming all Azure resources."
  type        = string
  default     = "Cato-vS-vWan"

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.azure_name_prefix)) && length(var.azure_name_prefix) >= 2 && length(var.azure_name_prefix) <= 24
    error_message = "Prefix must be 2-24 characters, start and end with alphanumeric characters, and contain only letters, numbers, and hyphens."
  }
}

variable "azure_primary_location" {
  description = "The primary Azure region to deploy shared resources like the vWAN and Resource Group."
  type        = string

  validation {
    condition = contains([
      "East US", "East US 2", "West US", "West US 2", "West US 3", "Central US", "North Central US", "South Central US", "West Central US",
      "North Europe", "West Europe", "France Central", "France South", "Germany West Central", "Germany North", "Norway East", "Norway West",
      "Sweden Central", "Switzerland North", "Switzerland West", "UK South", "UK West", "Poland Central",
      "Canada Central", "Canada East", "Brazil South", "South Africa North", "South Africa West",
      "Australia East", "Australia Southeast", "Australia Central", "Australia Central 2", "Central India", "South India", "West India", "Jio India Central", "Jio India West",
      "Japan East", "Japan West", "Korea Central", "Korea South", "East Asia", "Southeast Asia",
      "UAE North", "UAE Central", "Qatar Central"
    ], var.azure_primary_location)
    error_message = "Primary location must be a valid Azure region display name. Common regions include: East US, East US 2, West US 2, West Europe, North Europe, etc."
  }
}

variable "azure_create_resource_group" {
  description = "Set to true to create a new resource group. If false, existing_resource_group_name must be provided."
  type        = bool
  default     = true
}

variable "azure_resource_group_name" {
  description = "The name of the Azure Resource Group to create or use."
  type        = string
  default     = "cato-vsocket-vwan-rg"

  validation {
    condition     = can(regex("^[a-zA-Z0-9._()-]+[^.]$", var.azure_resource_group_name)) && length(var.azure_resource_group_name) >= 1 && length(var.azure_resource_group_name) <= 90
    error_message = "Resource group name must be 1-90 characters, can contain letters, numbers, underscores, hyphens, periods, and parentheses, and cannot end with a period."
  }
}

variable "azure_create_vwan" {
  description = "Set to true to create a new Virtual WAN. If false, existing Virtual WAN will be used."
  type        = bool
  default     = true
}

variable "deployment_subnet" {
  description = "The overall CIDR block for the entire deployment. This will be automatically subdivided between sites and hubs."
  type        = string
  default     = "10.57.0.0/16"

  validation {
    condition     = can(cidrhost(var.deployment_subnet, 0))
    error_message = "Deployment subnet must be valid CIDR notation (e.g., 10.57.0.0/16)."
  }
}

# --- BGP Configuration ---

variable "cato_bgp_asn" {
  description = "The BGP Autonomous System Number for the Cato side of the peering. Must not conflict with Azure vWAN's fixed ASN 65515."
  type        = number
  default     = 65001

  validation {
    condition     = var.cato_bgp_asn >= 64512 && var.cato_bgp_asn <= 65534 && var.cato_bgp_asn != 65515
    error_message = "Cato BGP ASN must be within the 16-bit private AS range (64512-65534) and cannot be 65515 (reserved for Azure vWAN hubs)."
  }
}

# Primary BGP Peer Configuration
variable "cato_primary_bgp_metric" {
  description = "BGP metric for the primary peer."
  type        = number
  default     = 100

  validation {
    condition     = var.cato_primary_bgp_metric >= 1 && var.cato_primary_bgp_metric <= 65535
    error_message = "BGP peer metric must be a 16-bit value between 1 and 65535."
  }
}

variable "cato_primary_bgp_default_action" {
  description = "Default action for primary BGP peer routes."
  type        = string
  default     = "ACCEPT"

  validation {
    condition     = contains(["ACCEPT", "DENY"], var.cato_primary_bgp_default_action)
    error_message = "BGP peer default_action must be either 'ACCEPT' or 'DENY'."
  }
}

variable "cato_primary_bgp_advertise_all_routes" {
  description = "Whether the primary BGP peer should advertise all routes."
  type        = bool
  default     = true
}

variable "cato_primary_bgp_advertise_default_route" {
  description = "Whether the primary BGP peer should advertise the default route."
  type        = bool
  default     = false
}

variable "cato_primary_bgp_advertise_summary_route" {
  description = "Whether the primary BGP peer should advertise summary routes."
  type        = bool
  default     = false
}

variable "cato_primary_bgp_bfd_enabled" {
  description = "Whether BFD is enabled for the primary BGP peer."
  type        = bool
  default     = false
}

# Secondary BGP Peer Configuration
variable "cato_secondary_bgp_metric" {
  description = "BGP metric for the secondary peer."
  type        = number
  default     = 200

  validation {
    condition     = var.cato_secondary_bgp_metric >= 1 && var.cato_secondary_bgp_metric <= 65535
    error_message = "BGP peer metric must be a 16-bit value between 1 and 65535."
  }
}

variable "cato_secondary_bgp_default_action" {
  description = "Default action for secondary BGP peer routes."
  type        = string
  default     = "ACCEPT"

  validation {
    condition     = contains(["ACCEPT", "DENY"], var.cato_secondary_bgp_default_action)
    error_message = "BGP peer default_action must be either 'ACCEPT' or 'DENY'."
  }
}

variable "cato_secondary_bgp_advertise_all_routes" {
  description = "Whether the secondary BGP peer should advertise all routes."
  type        = bool
  default     = true
}

variable "cato_secondary_bgp_advertise_default_route" {
  description = "Whether the secondary BGP peer should advertise the default route."
  type        = bool
  default     = false
}

variable "cato_secondary_bgp_summary_route" {
  description = "Whether the secondary BGP peer should advertise summary routes."
  type        = bool
  default     = false
}

variable "cato_secondary_bgp_enabled" {
  description = "Whether BFD is enabled for the secondary BGP peer."
  type        = bool
  default     = false
}

# --- Site 1 Configuration ---

variable "azure_site1_location" {
  description = "The Azure region for site 1."
  type        = string

  validation {
    condition = contains([
      "East US", "East US 2", "West US", "West US 2", "West US 3", "Central US", "North Central US", "South Central US", "West Central US",
      "North Europe", "West Europe", "France Central", "France South", "Germany West Central", "Germany North", "Norway East", "Norway West",
      "Sweden Central", "Switzerland North", "Switzerland West", "UK South", "UK West", "Poland Central",
      "Canada Central", "Canada East", "Brazil South", "South Africa North", "South Africa West",
      "Australia East", "Australia Southeast", "Australia Central", "Australia Central 2", "Central India", "South India", "West India", "Jio India Central", "Jio India West",
      "Japan East", "Japan West", "Korea Central", "Korea South", "East Asia", "Southeast Asia",
      "UAE North", "UAE Central", "Qatar Central"
    ], var.azure_site1_location)
    error_message = "Site 1 location must be a valid Azure region display name."
  }
}

variable "cato_site1_site_name" {
  description = "The name of the Cato Networks site 1."
  type        = string
  default     = "Azure-Cato-vS-vWAN-Site-HUB1"
}

variable "cato_site1_site_description" {
  description = "A brief description of site 1 for identification purposes."
  type        = string
  default     = "Multi-regional Cato vSocket vWAN site 1"
}

variable "cato_site1_site_type" {
  description = "The type of site 1 (DATACENTER, BRANCH, CLOUD_DC, HEADQUARTERS)."
  type        = string
  default     = "CLOUD_DC"

  validation {
    condition     = contains(["DATACENTER", "BRANCH", "CLOUD_DC", "HEADQUARTERS"], var.cato_site1_site_type)
    error_message = "The site_type variable must be one of 'DATACENTER','BRANCH','CLOUD_DC','HEADQUARTERS'."
  }
}

variable "cato_site1_native_network_range_cidr" {
  description = "Choose a unique range for site 1 that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.1.0.0/16)."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site1_native_network_range_cidr == null || can(cidrhost(var.cato_site1_native_network_range_cidr, 0))
    error_message = "Native network range must be valid CIDR notation (e.g., 10.1.0.0/16)."
  }
}

variable "azure_site1_vnet_network_range_cidr" {
  description = "Choose a unique range for site 1 Azure VNET that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.1.0.0/16)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site1_vnet_network_range_cidr == null || can(cidrhost(var.azure_site1_vnet_network_range_cidr, 0))
    error_message = "VNET network range must be valid CIDR notation (e.g., 10.1.0.0/16)."
  }
}

variable "azure_site1_subnet_range_mgmt_cidr" {
  description = "Management subnet range for site 1. Minimum /28 to support HA. CIDR notation (e.g. 10.1.1.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site1_subnet_range_mgmt_cidr == null || can(cidrhost(var.azure_site1_subnet_range_mgmt_cidr, 0))
    error_message = "Management subnet range must be valid CIDR notation (e.g., 10.1.1.0/24)."
  }
}

variable "azure_site1_subnet_range_wan_cidr" {
  description = "WAN/Public subnet range for site 1. Minimum /28 to support HA. CIDR notation (e.g. 10.1.2.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site1_subnet_range_wan_cidr == null || can(cidrhost(var.azure_site1_subnet_range_wan_cidr, 0))
    error_message = "WAN subnet range must be valid CIDR notation (e.g., 10.1.2.0/24)."
  }
}

variable "azure_site1_subnet_range_lan_cidr" {
  description = "LAN/Private subnet range for site 1. Minimum /29 to support HA. CIDR notation (e.g. 10.1.3.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site1_subnet_range_lan_cidr == null || can(cidrhost(var.azure_site1_subnet_range_lan_cidr, 0))
    error_message = "LAN subnet range must be valid CIDR notation (e.g., 10.1.3.0/24)."
  }
}

variable "cato_site1_floating_ip" {
  description = "The floating IP address used for High Availability (HA) failover for site 1."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site1_floating_ip == null || can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cato_site1_floating_ip))
    error_message = "Floating IP must be a valid IPv4 address."
  }
}

variable "cato_site1_primary_lan_ip" {
  description = "Local IP Address of site 1 primary socket LAN interface."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site1_primary_lan_ip == null || can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cato_site1_primary_lan_ip))
    error_message = "Primary LAN IP must be a valid IPv4 address."
  }
}

variable "cato_site1_secondary_lan_ip" {
  description = "Local IP Address of site 1 secondary socket LAN interface."
  type        = string
  default     = null


  validation {
    condition     = var.cato_site1_secondary_lan_ip == null || can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cato_site1_secondary_lan_ip))
    error_message = "Secondary LAN IP must be a valid IPv4 address."
  }
}

variable "cato_site1_vm_size" {
  description = "Specifies the size of the Virtual Machine for site 1. See Azure VM Naming Conventions."
  type        = string
  default     = "Standard_D8ls_v5"
}

variable "azure_site1_create_hub" {
  description = "Set to true to create a new Virtual WAN hub for site 1."
  type        = bool
  default     = true
}

variable "azure_site1_hub_address_prefix" {
  description = "The address prefix for the Virtual WAN hub for site 1. CIDR notation (e.g. 10.101.0.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site1_hub_address_prefix == null || can(cidrhost(var.azure_site1_hub_address_prefix, 0))
    error_message = "Hub address prefix must be a valid CIDR notation if provided."
  }
}

variable "azure_site1_hub_routing_preference" {
  description = "Hub routing preference for site 1. Options: ASPath (default), ExpressRoute, or VpnGateway."
  type        = string
  default     = "ASPath"

  validation {
    condition     = contains(["ASPath", "ExpressRoute", "VpnGateway"], var.azure_site1_hub_routing_preference)
    error_message = "Hub routing preference must be one of: ASPath (default, best AS path), ExpressRoute (prioritize ExpressRoute), or VpnGateway (prioritize VPN Gateway)."
  }
}

# --- Site 2 Configuration ---

variable "azure_site2_location" {
  description = "The Azure region for site 2."
  type        = string

  validation {
    condition = contains([
      "East US", "East US 2", "West US", "West US 2", "West US 3", "Central US", "North Central US", "South Central US", "West Central US",
      "North Europe", "West Europe", "France Central", "France South", "Germany West Central", "Germany North", "Norway East", "Norway West",
      "Sweden Central", "Switzerland North", "Switzerland West", "UK South", "UK West", "Poland Central",
      "Canada Central", "Canada East", "Brazil South", "South Africa North", "South Africa West",
      "Australia East", "Australia Southeast", "Australia Central", "Australia Central 2", "Central India", "South India", "West India", "Jio India Central", "Jio India West",
      "Japan East", "Japan West", "Korea Central", "Korea South", "East Asia", "Southeast Asia",
      "UAE North", "UAE Central", "Qatar Central"
    ], var.azure_site2_location)
    error_message = "Site 2 location must be a valid Azure region display name."
  }
}

variable "cato_site2_site_name" {
  description = "The name of the Cato Networks site 2."
  type        = string
  default     = "Azure-Cato-vS-vWAN-Site-HUB2"
}

variable "cato_site2_site_description" {
  description = "A brief description of site 2 for identification purposes."
  type        = string
  default     = "Multi-regional Cato vSocket site 2"
}

variable "cato_site2_site_type" {
  description = "The type of site 2 (DATACENTER, BRANCH, CLOUD_DC, HEADQUARTERS)."
  type        = string
  default     = "CLOUD_DC"

  validation {
    condition     = contains(["DATACENTER", "BRANCH", "CLOUD_DC", "HEADQUARTERS"], var.cato_site2_site_type)
    error_message = "The site_type variable must be one of 'DATACENTER','BRANCH','CLOUD_DC','HEADQUARTERS'."
  }
}

variable "cato_site2_native_network_range_cidr" {
  description = "Choose a unique range for site 2 that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.2.0.0/16)."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site2_native_network_range_cidr == null || can(cidrhost(var.cato_site2_native_network_range_cidr, 0))
    error_message = "Native network range must be valid CIDR notation (e.g., 10.2.0.0/16)."
  }
}

variable "azure_site2_vnet_network_range_cidr" {
  description = "Choose a unique range for site 2 Azure VNET that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.2.0.0/16)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site2_vnet_network_range_cidr == null || can(cidrhost(var.azure_site2_vnet_network_range_cidr, 0))
    error_message = "VNET network range must be valid CIDR notation (e.g., 10.2.0.0/16)."
  }
}

variable "azure_site2_subnet_range_mgmt_cidr" {
  description = "Management subnet range for site 2. Minimum /28 to support HA. CIDR notation (e.g. 10.2.1.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site2_subnet_range_mgmt_cidr == null || can(cidrhost(var.azure_site2_subnet_range_mgmt_cidr, 0))
    error_message = "Management subnet range must be valid CIDR notation (e.g., 10.2.1.0/24)."
  }
}

variable "azure_site2_subnet_range_wan_cidr" {
  description = "WAN/Public subnet range for site 2. Minimum /28 to support HA. CIDR notation (e.g. 10.2.2.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site2_subnet_range_wan_cidr == null || can(cidrhost(var.azure_site2_subnet_range_wan_cidr, 0))
    error_message = "WAN subnet range must be valid CIDR notation (e.g., 10.2.2.0/24)."
  }
}

variable "azure_site2_subnet_range_lan_cidr" {
  description = "LAN/Private subnet range for site 2. Minimum /29 to support HA. CIDR notation (e.g. 10.2.3.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site2_subnet_range_lan_cidr == null || can(cidrhost(var.azure_site2_subnet_range_lan_cidr, 0))
    error_message = "LAN subnet range must be valid CIDR notation (e.g., 10.2.3.0/24)."
  }
}

variable "cato_site2_floating_ip" {
  description = "The floating IP address used for High Availability (HA) failover for site 2."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site2_floating_ip == null || can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cato_site2_floating_ip))
    error_message = "Floating IP must be a valid IPv4 address."
  }
}

variable "cato_site2_primary_lan_ip" {
  description = "Local IP Address of site 2 primary socket LAN interface."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site2_primary_lan_ip == null || can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cato_site2_primary_lan_ip))
    error_message = "Primary LAN IP must be a valid IPv4 address."
  }
}

variable "cato_site2_secondary_lan_ip" {
  description = "Local IP Address of site 2 secondary socket LAN interface."
  type        = string
  default     = null

  validation {
    condition     = var.cato_site2_secondary_lan_ip == null || can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cato_site2_secondary_lan_ip))
    error_message = "Secondary LAN IP must be a valid IPv4 address."
  }
}

variable "cato_site2_vm_size" {
  description = "Specifies the size of the Virtual Machine for site 2. See Azure VM Naming Conventions."
  type        = string
  default     = "Standard_D8ls_v5"
}

variable "azure_site2_create_hub" {
  description = "Set to true to create a new Virtual WAN hub for site 2."
  type        = bool
  default     = true
}

variable "azure_site2_hub_address_prefix" {
  description = "The address prefix for the Virtual WAN hub for site 2. CIDR notation (e.g. 10.102.0.0/24)."
  type        = string
  default     = null

  validation {
    condition     = var.azure_site2_hub_address_prefix == null || can(cidrhost(var.azure_site2_hub_address_prefix, 0))
    error_message = "Hub address prefix must be a valid CIDR notation if provided."
  }
}

variable "azure_site2_hub_routing_preference" {
  description = "Hub routing preference for site 2. Options: ASPath (default), ExpressRoute, or VpnGateway."
  type        = string
  default     = "ASPath"

  validation {
    condition     = contains(["ASPath", "ExpressRoute", "VpnGateway"], var.azure_site2_hub_routing_preference)
    error_message = "Hub routing preference must be one of: ASPath (default, best AS path), ExpressRoute (prioritize ExpressRoute), or VpnGateway (prioritize VPN Gateway)."
  }
}

# --- Additional Configuration ---

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}

