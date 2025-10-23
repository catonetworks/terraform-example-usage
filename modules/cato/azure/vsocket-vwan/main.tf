locals {
  # Carve the main /16 into two /18 blocks, one for each site
  site_1_block = cidrsubnet(var.deployment_subnet, 2, 0) # 10.57.0.0/18
  site_2_block = cidrsubnet(var.deployment_subnet, 2, 1) # 10.57.64.0/18

  # --- Site 1 Network Calculation ---
  # Split the site's /18 block into two /19s for the vNet and Hub
  site_1_vnet_cidr = cidrsubnet(local.site_1_block, 1, 0)                   # 10.57.0.0/19
  site_1_hub_cidr  = cidrsubnet(cidrsubnet(local.site_1_block, 1, 1), 5, 0) # 10.57.32.0/24

  # --- Site 2 Network Calculation ---
  # Split the site's /18 block into two /19s for the vNet and Hub
  site_2_vnet_cidr = cidrsubnet(local.site_2_block, 1, 0)                   # 10.57.64.0/19
  site_2_hub_cidr  = cidrsubnet(cidrsubnet(local.site_2_block, 1, 1), 5, 0) # 10.57.96.0/24
}


module "cato_multisite_vwan" {
  source = "catonetworks/azure-vwan-vsocket-ha/cato"

  # Global Configuration 
  prefix                = var.azure_name_prefix
  primary_location      = var.azure_primary_location
  create_resource_group = var.azure_create_resource_group
  resource_group_name   = var.azure_resource_group_name

  create_vwan = var.azure_create_vwan

  baseurl               = var.baseurl
  cato_token            = var.cato_token
  cato_account_id       = var.cato_account_id
  azure_subscription_id = var.azure_subscription_id

  # BGP Configuration
  # IMPORTANT: Azure vWAN hubs always use ASN 65515 (Microsoft fixed)
  # Your Cato ASN must be different to avoid conflicts
  cato_bgp_asn = var.cato_bgp_asn # Private ASN: 64512-65534 (not 65515)

  cato_bgp_peer_config = {
    primary = {
      metric                   = var.cato_primary_bgp_metric
      default_action           = var.cato_primary_bgp_default_action
      advertise_all_routes     = var.cato_primary_bgp_advertise_all_routes
      advertise_default_route  = var.cato_primary_bgp_advertise_default_route
      advertise_summary_routes = var.cato_primary_bgp_advertise_summary_route
      bfd_enabled              = var.cato_primary_bgp_bfd_enabled
    }
    secondary = {
      metric                   = var.cato_secondary_bgp_metric
      default_action           = var.cato_secondary_bgp_default_action
      advertise_all_routes     = var.cato_secondary_bgp_advertise_all_routes
      advertise_default_route  = var.cato_secondary_bgp_advertise_default_route
      advertise_summary_routes = var.cato_secondary_bgp_summary_route
      bfd_enabled              = var.cato_secondary_bgp_enabled
    }
  }

  regional_config = {

    site_1 = {
      location         = var.azure_site1_location
      site_name        = var.cato_site1_site_name
      site_description = var.cato_site1_site_description
      site_type        = var.cato_site1_site_type

      # Network Configuration (derived from locals)
      native_network_range = var.cato_site1_native_network_range_cidr == null ? local.site_1_vnet_cidr : var.cato_site1_native_network_range_cidr
      vnet_network_range   = local.site_1_vnet_cidr
      subnet_range_mgmt    = var.azure_site1_subnet_range_mgmt_cidr == null ? cidrsubnet(local.site_1_vnet_cidr, 5, 0) : var.azure_site1_subnet_range_mgmt_cidr
      subnet_range_wan     = var.azure_site1_subnet_range_wan_cidr == null ? cidrsubnet(local.site_1_vnet_cidr, 5, 1) : var.azure_site1_subnet_range_wan_cidr
      subnet_range_lan     = var.azure_site1_subnet_range_lan_cidr == null ? cidrsubnet(local.site_1_vnet_cidr, 5, 2) : var.azure_site1_subnet_range_lan_cidr

      # HA Configuration
      floating_ip      = var.cato_site1_floating_ip == null ? cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 8) : var.cato_site1_floating_ip
      lan_ip_primary   = var.cato_site1_primary_lan_ip == null ? cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 6) : var.cato_site1_primary_lan_ip
      lan_ip_secondary = var.cato_site1_secondary_lan_ip == null ? cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 7) : var.cato_site1_secondary_lan_ip

      # VM Configuration
      vm_size = var.cato_site1_vm_size

      # Hub Configuration
      create_hub             = var.azure_site1_create_hub
      hub_address_prefix     = local.site_1_hub_cidr
      hub_routing_preference = var.azure_site1_hub_routing_preference
    }

    site_2 = {
      location         = var.azure_site2_location
      site_name        = var.cato_site2_site_name
      site_description = var.cato_site2_site_description
      site_type        = var.cato_site2_site_type

      # Network Configuration (derived from locals)
      native_network_range = var.cato_site2_native_network_range_cidr == null ? local.site_2_vnet_cidr : var.cato_site2_native_network_range_cidr
      vnet_network_range   = local.site_2_vnet_cidr
      subnet_range_mgmt    = var.azure_site2_subnet_range_mgmt_cidr == null ? cidrsubnet(local.site_2_vnet_cidr, 5, 0) : var.azure_site2_subnet_range_mgmt_cidr
      subnet_range_wan     = var.azure_site2_subnet_range_wan_cidr == null ? cidrsubnet(local.site_2_vnet_cidr, 5, 1) : var.azure_site2_subnet_range_wan_cidr
      subnet_range_lan     = var.azure_site2_subnet_range_lan_cidr == null ? cidrsubnet(local.site_2_vnet_cidr, 5, 2) : var.azure_site2_subnet_range_lan_cidr

      # HA Configuration
      floating_ip      = var.cato_site2_floating_ip == null ? cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 8) : var.cato_site2_floating_ip
      lan_ip_primary   = var.cato_site2_primary_lan_ip == null ? cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 6) : var.cato_site2_primary_lan_ip
      lan_ip_secondary = var.cato_site2_secondary_lan_ip == null ? cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 7) : var.cato_site2_secondary_lan_ip

      # VM Configuration
      vm_size = var.cato_site2_vm_size

      # Hub Configuration
      create_hub             = var.azure_site2_create_hub
      hub_address_prefix     = local.site_2_hub_cidr
      hub_routing_preference = var.azure_site2_hub_routing_preference
    }
  }

  tags = var.tags
}
