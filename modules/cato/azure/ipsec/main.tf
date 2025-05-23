
# !!!!! DEPENDENCY !!!!! 
# Create 2 allocated IPs in Cato Management Application(CMA), retrieve the IPs and the IDs via API/CLI
# The IPs will be used for the primary and secondary tunnels
# https://support.catonetworks.com/hc/en-us/articles/4413273467153-Allocating-IP-Addresses-for-the-Account

# Create Azure resources first
module "vnet" {
  source               = "../../../azure/vnet-ipsec"
  az_location          = var.az_location
  site_name            = var.site_name
  native_network_range = var.native_network_range
}

module "ipsec-azure" {
  depends_on                  = [module.vnet]
  source                      = "catonetworks/ipsec-azure/cato"
  token                       = var.token
  account_id                  = var.account_id
  resource_group_name         = module.vnet.resource_group_name
  vnet_name                   = module.vnet.vnet_name
  az_location                 = var.az_location
  vpn_gateway_name            = var.vpn_gateway_name
  site_name                   = var.site_name
  site_description            = var.site_description
  native_network_range        = var.native_network_range
  local_network_gateway_name  = var.local_network_gateway_name
  site_location               = var.site_location
  primary_cato_pop_ip         = var.primary_cato_pop_ip
  secondary_cato_pop_ip       = var.secondary_cato_pop_ip
  primary_public_cato_ip_id   = var.primary_public_cato_ip_id
  primary_private_cato_ip     = var.primary_private_cato_ip
  primary_private_site_ip     = var.primary_private_site_ip
  secondary_public_cato_ip_id = var.secondary_public_cato_ip_id
  secondary_private_cato_ip   = var.secondary_private_cato_ip
  secondary_private_site_ip   = var.secondary_private_site_ip
  downstream_bw               = var.downstream_bw
  upstream_bw                 = var.upstream_bw
  gateway_subnet_id           = module.vnet.subnet_id
}
