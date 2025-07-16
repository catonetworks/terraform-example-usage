## Create Cato SocketSite and Deploy Vsocket, HA and a Vnet
module "vsocket-azure-ha-vnet" {
  source                = "catonetworks/vsocket-azure-ha-vnet/cato"
  token                 = var.token
  account_id            = var.account_id
  azure_subscription_id = var.azure_subscription_id
  location              = var.location
  subnet_range_mgmt     = var.subnet_range_mgmt == null ? cidrsubnet(var.vnet_prefix, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan      = var.subnet_range_wan == null ? cidrsubnet(var.vnet_prefix, 8, 1) : var.subnet_range_wan
  subnet_range_lan      = var.subnet_range_lan == null ? cidrsubnet(var.vnet_prefix, 8, 2) : var.subnet_range_lan
  lan_ip_primary        = var.lan_ip_primary == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 5) : var.lan_ip_primary
  lan_ip_secondary      = var.lan_ip_secondary == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 6) : var.lan_ip_secondary
  floating_ip           = var.floating_ip == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 7) : var.floating_ip
  native_network_range  = var.vnet_prefix
  vnet_network_range    = var.vnet_prefix
  dns_servers           = var.dns_servers
  site_name             = var.site_name
  site_description      = var.site_description
  site_location         = var.site_location
}
