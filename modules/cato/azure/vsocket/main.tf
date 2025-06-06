## Create Azure Resource Group and Virtual Network
module "vnet" {
  source            = "../../../azure/vnet-vsocket"
  location          = var.location
  site_name         = var.site_name
  subnet_range_mgmt = var.subnet_range_mgmt == null ? cidrsubnet(var.vnet_prefix, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan  = var.subnet_range_wan == null ? cidrsubnet(var.vnet_prefix, 8, 1) : var.subnet_range_wan
  subnet_range_lan  = var.subnet_range_lan == null ? cidrsubnet(var.vnet_prefix, 8, 2) : var.subnet_range_lan
  lan_ip            = var.lan_ip == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 5) : var.lan_ip
  dns_servers       = var.dns_servers
  vnet_prefix       = var.vnet_prefix
}

## Create Cato SocketSite and Deploy Vsocket
module "vsocket-azure" {
  depends_on           = [module.vnet]
  source               = "catonetworks/vsocket-azure/cato"
  lan_ip               = var.lan_ip == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 5) : var.lan_ip
  location             = var.location
  native_network_range = var.subnet_range_lan == null ? cidrsubnet(var.vnet_prefix, 8, 2) : var.subnet_range_lan
  resource_group_name  = module.vnet.resource_group_name
  mgmt_nic_name          = module.vnet.mgmt-nic-name
  wan_nic_name           = module.vnet.wan-nic-name
  lan_nic_name           = module.vnet.lan-nic-name
  site_name            = var.site_name
  site_description     = var.site_description
  site_type            = var.site_type
  site_location        = var.site_location
}
