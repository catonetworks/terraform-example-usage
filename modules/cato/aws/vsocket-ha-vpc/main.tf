module "vsocket-aws-ha-vpc" {
  source                     = "catonetworks/vsocket-aws-ha-vpc/cato"
  token                      = var.token
  account_id                 = var.account_id
  vpc_id                     = var.vpc_id
  internet_gateway_id        = var.internet_gateway_id
  vpc_range                  = var.vpc_range
  key_pair                   = var.key_pair
  site_name                  = var.site_name
  site_description           = var.site_description
  site_type                  = var.site_type
  subnet_range_mgmt          = var.subnet_range_mgmt == null ? cidrsubnet(var.vpc_range, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan           = var.subnet_range_wan == null ? cidrsubnet(var.vpc_range, 8, 1) : var.subnet_range_wan
  subnet_range_lan_primary   = var.subnet_range_lan_primary == null ? cidrsubnet(var.vpc_range, 8, 2) : var.subnet_range_lan_primary
  subnet_range_lan_secondary = var.subnet_range_lan_secondary == null ? cidrsubnet(var.vpc_range, 8, 3) : var.subnet_range_lan_secondary
  mgmt_eni_primary_ip        = var.mgmt_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 0), 5) : var.mgmt_eni_primary_ip
  mgmt_eni_secondary_ip      = var.mgmt_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 0), 6) : var.mgmt_eni_secondary_ip
  wan_eni_primary_ip         = var.wan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 1), 5) : var.wan_eni_primary_ip
  wan_eni_secondary_ip       = var.wan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 1), 6) : var.wan_eni_secondary_ip
  lan_eni_primary_ip         = var.lan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 2), 5) : var.lan_eni_primary_ip
  lan_eni_secondary_ip       = var.lan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 3), 5) : var.lan_eni_secondary_ip
  ingress_cidr_blocks        = var.ingress_cidr_blocks
  lan_ingress_cidr_blocks    = var.lan_ingress_cidr_blocks
  site_location              = var.site_location
  tags                       = var.tags
}