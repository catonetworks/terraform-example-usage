# ===============================================================================
# Azure vWAN vSocket HA Module Outputs
# ===============================================================================

# --- Module Configuration Summary ---
output "deployment_config" {
  description = "Configuration summary of the deployment"
  value = {
    deployment_subnet     = var.deployment_subnet
    primary_location      = var.azure_primary_location
    name_prefix           = var.azure_name_prefix
    resource_group_name   = var.azure_resource_group_name
    create_resource_group = var.azure_create_resource_group
    create_vwan           = var.azure_create_vwan
    cato_bgp_asn          = var.cato_bgp_asn
    sites_deployed = {
      site_1 = {
        location = var.azure_site1_location
        name     = var.cato_site1_site_name
      }
      site_2 = {
        location = var.azure_site2_location
        name     = var.cato_site2_site_name
      }
    }
  }
}

# --- Network Configuration ---
output "network_configuration" {
  description = "Detailed network configuration showing calculated and assigned ranges"
  value = {
    deployment_subnet = var.deployment_subnet
    site_blocks = {
      site_1 = {
        overall_block = local.site_1_block
        vnet_cidr     = local.site_1_vnet_cidr
        hub_cidr      = local.site_1_hub_cidr
        subnets = {
          management = coalesce(var.azure_site1_subnet_range_mgmt_cidr, cidrsubnet(local.site_1_vnet_cidr, 5, 0))
          wan        = coalesce(var.azure_site1_subnet_range_wan_cidr, cidrsubnet(local.site_1_vnet_cidr, 5, 1))
          lan        = coalesce(var.azure_site1_subnet_range_lan_cidr, cidrsubnet(local.site_1_vnet_cidr, 5, 2))
        }
        ips = {
          floating_ip      = coalesce(var.cato_site1_floating_ip, cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 8))
          lan_ip_primary   = coalesce(var.cato_site1_primary_lan_ip, cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 6))
          lan_ip_secondary = coalesce(var.cato_site1_secondary_lan_ip, cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 7))
        }
      }
      site_2 = {
        overall_block = local.site_2_block
        vnet_cidr     = local.site_2_vnet_cidr
        hub_cidr      = local.site_2_hub_cidr
        subnets = {
          management = coalesce(var.azure_site2_subnet_range_mgmt_cidr, cidrsubnet(local.site_2_vnet_cidr, 5, 0))
          wan        = coalesce(var.azure_site2_subnet_range_wan_cidr, cidrsubnet(local.site_2_vnet_cidr, 5, 1))
          lan        = coalesce(var.azure_site2_subnet_range_lan_cidr, cidrsubnet(local.site_2_vnet_cidr, 5, 2))
        }
        ips = {
          floating_ip      = coalesce(var.cato_site2_floating_ip, cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 8))
          lan_ip_primary   = coalesce(var.cato_site2_primary_lan_ip, cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 6))
          lan_ip_secondary = coalesce(var.cato_site2_secondary_lan_ip, cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 7))
        }
      }
    }
  }
}

# --- Deployment Summary (from underlying module) ---
output "deployment_summary" {
  description = "Comprehensive summary of deployed resources across all sites"
  value       = module.cato_multisite_vwan.regional_deployment_summary
  sensitive   = true
}

# --- Cato Sites Information ---
output "cato_sites" {
  description = "Information about created Cato sites"
  value = {
    site_ids          = module.cato_multisite_vwan.cato_site_id
    site_names        = module.cato_multisite_vwan.cato_site_name
    primary_serials   = module.cato_multisite_vwan.cato_primary_serial
    secondary_serials = module.cato_multisite_vwan.cato_secondary_serial
    sites_count       = length(module.cato_multisite_vwan.cato_site_id)
  }
}

# --- Virtual Machine Details ---
output "virtual_machines" {
  description = "Details about the deployed vSocket virtual machines"
  value = {
    primary_vms = {
      ids   = module.cato_multisite_vwan.vsocket_primary_vm_id
      names = module.cato_multisite_vwan.vsocket_primary_vm_name
    }
    secondary_vms = {
      ids   = module.cato_multisite_vwan.vsocket_secondary_vm_id
      names = module.cato_multisite_vwan.vsocket_secondary_vm_name
    }
    vm_sizes = {
      site_1 = var.cato_site1_vm_size
      site_2 = var.cato_site2_vm_size
    }
    total_vms = length(module.cato_multisite_vwan.vsocket_primary_vm_id) + length(module.cato_multisite_vwan.vsocket_secondary_vm_id)
  }
}

# --- Azure Infrastructure ---
output "azure_infrastructure" {
  description = "Azure infrastructure components created by the deployment"
  value = {
    resource_group_name = module.cato_multisite_vwan.resource_group_name
    virtual_wan = {
      id          = module.cato_multisite_vwan.virtual_wan_id
      created_new = var.azure_create_vwan
    }
    virtual_networks = module.cato_multisite_vwan.vnet_name
    subnets = {
      lan_subnet_ids   = module.cato_multisite_vwan.lan_subnet_id
      lan_subnet_names = module.cato_multisite_vwan.lan_subnet_name
    }
  }
}

# --- Virtual WAN Hubs ---
output "vwan_hubs" {
  description = "Virtual WAN hub information and configuration"
  value = {
    hub_details = module.cato_multisite_vwan.virtual_hub_details
    hub_config = {
      site_1 = {
        create_hub             = var.azure_site1_create_hub
        hub_routing_preference = var.azure_site1_hub_routing_preference
        calculated_hub_cidr    = local.site_1_hub_cidr
      }
      site_2 = {
        create_hub             = var.azure_site2_create_hub
        hub_routing_preference = var.azure_site2_hub_routing_preference
        calculated_hub_cidr    = local.site_2_hub_cidr
      }
    }
    hubs_count = length(module.cato_multisite_vwan.virtual_hub_details)
  }
}

# --- BGP Configuration & Status ---
output "bgp_configuration" {
  description = "BGP peering configuration and connection details"
  value = {
    cato_asn  = var.cato_bgp_asn
    azure_asn = 65515 # Azure vWAN fixed ASN
    peer_config = {
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
    active_peers = {
      cato_bgp_peers        = module.cato_multisite_vwan.cato_bgp_peer_details
      azure_bgp_connections = module.cato_multisite_vwan.azure_bgp_connection_details
    }
    peers_count = length(module.cato_multisite_vwan.cato_bgp_peer_details)
  }
}

# --- High Availability Configuration ---
output "ha_configuration" {
  description = "High Availability configuration details for both sites"
  value = {
    site_1 = {
      floating_ip      = coalesce(var.cato_site1_floating_ip, cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 8))
      lan_ip_primary   = coalesce(var.cato_site1_primary_lan_ip, cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 6))
      lan_ip_secondary = coalesce(var.cato_site1_secondary_lan_ip, cidrhost(cidrsubnet(local.site_1_vnet_cidr, 5, 2), 7))
      ha_identity_id   = try(module.cato_multisite_vwan.ha_identity_id["site_1"], "N/A")
    }
    site_2 = {
      floating_ip      = coalesce(var.cato_site2_floating_ip, cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 8))
      lan_ip_primary   = coalesce(var.cato_site2_primary_lan_ip, cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 6))
      lan_ip_secondary = coalesce(var.cato_site2_secondary_lan_ip, cidrhost(cidrsubnet(local.site_2_vnet_cidr, 5, 2), 7))
      ha_identity_id   = try(module.cato_multisite_vwan.ha_identity_id["site_2"], "N/A")
    }
  }
}

# --- Deployment Validation ---
output "deployment_validation" {
  description = "Validation information to verify successful deployment"
  value = {
    expected_sites     = 2
    actual_sites       = length(module.cato_multisite_vwan.cato_site_id)
    expected_vms       = 4 # 2 primary + 2 secondary
    actual_vms         = length(module.cato_multisite_vwan.vsocket_primary_vm_id) + length(module.cato_multisite_vwan.vsocket_secondary_vm_id)
    expected_hubs      = var.azure_site1_create_hub && var.azure_site2_create_hub ? 2 : (var.azure_site1_create_hub || var.azure_site2_create_hub ? 1 : 0)
    actual_hubs        = length(module.cato_multisite_vwan.virtual_hub_details)
    expected_bgp_peers = 4 # 2 primary + 2 secondary
    actual_bgp_peers   = length(module.cato_multisite_vwan.cato_bgp_peer_details)
    deployment_healthy = (
      length(module.cato_multisite_vwan.cato_site_id) == 2 &&
      length(module.cato_multisite_vwan.vsocket_primary_vm_id) + length(module.cato_multisite_vwan.vsocket_secondary_vm_id) == 4 &&
      length(module.cato_multisite_vwan.cato_bgp_peer_details) > 0
    )
  }
}

# --- Resource Tags ---
output "resource_tags" {
  description = "Tags applied to resources"
  value       = var.tags
}
