module "vnet-ha" {
  source            = "../../../azure/vnet-vsocket-ha"
  location          = var.location
  site_name         = var.site_name
  subnet_range_mgmt = var.subnet_range_mgmt == null ? cidrsubnet(var.vnet_prefix, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan  = var.subnet_range_wan == null ? cidrsubnet(var.vnet_prefix, 8, 1) : var.subnet_range_wan
  subnet_range_lan  = var.subnet_range_lan == null ? cidrsubnet(var.vnet_prefix, 8, 2) : var.subnet_range_lan
  lan_ip_primary    = var.lan_ip_primary == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 5) : var.lan_ip_primary
  lan_ip_secondary  = var.lan_ip_secondary == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 6) : var.lan_ip_secondary
  floating_ip       = var.floating_ip == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 7) : var.floating_ip
  dns_servers       = var.dns_servers
  vnet_prefix       = var.vnet_prefix
}

## Create Cato SocketSite and Deploy Vsocket-HA
module "vsocket-azure-ha" {
  depends_on = [module.vnet-ha]
  # source                  = "catonetworks/vsocket-azure-ha/cato"
  source                  = "../../../../../terraform-cato-vsocket-azure-ha"
  token                   = var.token
  account_id              = var.account_id
  azure_subscription_id   = var.azure_subscription_id
  resource_group_name     = module.vnet-ha.resource_group_name
  location                = var.location
  vnet_name               = module.vnet-ha.vnet_name
  lan_subnet_name         = module.vnet-ha.lan_subnet_name
  vnet_prefix             = var.vnet_prefix
  dns_servers             = var.dns_servers
  lan_prefix              = var.subnet_range_lan == null ? cidrsubnet(var.vnet_prefix, 8, 2) : var.subnet_range_lan
  floating_ip             = var.floating_ip == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 7) : var.floating_ip
  site_name               = var.site_name
  site_description        = var.site_description
  site_location           = var.site_location
  mgmt_nic_name_primary   = module.vnet-ha.mgmt_nic_name_primary
  mgmt_nic_name_secondary = module.vnet-ha.mgmt_nic_name_secondary
  wan_nic_name_primary    = module.vnet-ha.wan_nic_name_primary
  wan_nic_name_secondary  = module.vnet-ha.wan_nic_name_secondary
  lan_nic_name_primary    = module.vnet-ha.lan_nic_name_primary
  lan_nic_name_secondary  = module.vnet-ha.lan_nic_name_secondary
}
