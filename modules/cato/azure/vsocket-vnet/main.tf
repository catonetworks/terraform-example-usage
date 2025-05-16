# ## Create Cato SocketSite and Deploy Vsocket
module "vsocket-azure-vnet" {
  source            = "catonetworks/vsocket-azure-vnet/cato"
  vnet_prefix       = var.vnet_prefix
  subnet_range_mgmt = var.subnet_range_mgmt == null ? cidrsubnet(var.vnet_prefix, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan  = var.subnet_range_wan == null ? cidrsubnet(var.vnet_prefix, 8, 1) : var.subnet_range_wan
  subnet_range_lan  = var.subnet_range_lan == null ? cidrsubnet(var.vnet_prefix, 8, 2) : var.subnet_range_lan
  dns_servers       = var.dns_servers
  lan_ip            = var.lan_ip == null ? cidrhost(cidrsubnet(var.vnet_prefix, 8, 2), 5) : var.lan_ip
  site_name         = var.site_name
  site_description  = var.site_description
  site_type         = var.site_type
  site_location     = var.site_location
  az_location       = var.location
}
