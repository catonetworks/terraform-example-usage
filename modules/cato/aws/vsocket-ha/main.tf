module "vpc" {
  source    = "../../../aws/vpc-vsocket-ha"
  vpc_range = var.vpc_range
  # Use unique indices 0–5 to avoid overlap
  subnet_range_mgmt_primary   = var.subnet_range_mgmt_primary == null ? cidrsubnet(var.vpc_range, 9, 0) : var.subnet_range_mgmt_primary
  subnet_range_mgmt_secondary = var.subnet_range_mgmt_secondary == null ? cidrsubnet(var.vpc_range, 9, 1) : var.subnet_range_mgmt_secondary
  subnet_range_wan_primary    = var.subnet_range_wan_primary == null ? cidrsubnet(var.vpc_range, 9, 2) : var.subnet_range_wan_primary
  subnet_range_wan_secondary  = var.subnet_range_wan_secondary == null ? cidrsubnet(var.vpc_range, 9, 3) : var.subnet_range_wan_secondary
  subnet_range_lan_primary    = var.subnet_range_lan_primary == null ? cidrsubnet(var.vpc_range, 9, 4) : var.subnet_range_lan_primary
  subnet_range_lan_secondary  = var.subnet_range_lan_secondary == null ? cidrsubnet(var.vpc_range, 9, 5) : var.subnet_range_lan_secondary
  mgmt_eni_primary_ip         = var.mgmt_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 0), 5) : var.mgmt_eni_primary_ip
  mgmt_eni_secondary_ip       = var.mgmt_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 1), 5) : var.mgmt_eni_secondary_ip
  wan_eni_primary_ip          = var.wan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 2), 5) : var.wan_eni_primary_ip
  wan_eni_secondary_ip        = var.wan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 3), 5) : var.wan_eni_secondary_ip
  lan_eni_primary_ip          = var.lan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 4), 5) : var.lan_eni_primary_ip
  lan_eni_secondary_ip        = var.lan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 5), 5) : var.lan_eni_secondary_ip

  ingress_cidr_blocks = var.ingress_cidr_blocks
}

module "vsocket-aws-ha" {
  source                         = "catonetworks/vsocket-aws-ha/cato"
  token                          = var.token
  account_id                     = var.account_id
  vpc_id                         = module.vpc.vpc_id
  key_pair                       = var.key_pair
  site_name                      = var.site_name
  site_description               = var.site_description
  site_type                      = var.site_type
  native_network_range_primary   = var.subnet_range_lan_primary == null ? cidrsubnet(var.vpc_range, 9, 4) : var.subnet_range_lan_primary
  native_network_range_secondary = var.subnet_range_lan_secondary == null ? cidrsubnet(var.vpc_range, 9, 5) : var.subnet_range_lan_secondary
  lan_local_primary_ip           = var.lan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 4), 5) : var.lan_eni_primary_ip
  lan_local_secondary_ip         = var.lan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 9, 5), 5) : var.lan_eni_secondary_ip
  mgmt_subnet_id                 = module.vpc.mgmt_subnet_primary_id
  wan_subnet_id                  = module.vpc.wan_subnet_primary_id
  lan_subnet_primary_id          = module.vpc.lan_subnet_primary_id
  lan_subnet_secondary_id        = module.vpc.lan_subnet_secondary_id
  mgmt_eni_primary_id            = module.vpc.mgmt_eni_primary_id
  wan_eni_primary_id             = module.vpc.wan_eni_primary_id
  lan_eni_primary_id             = module.vpc.lan_eni_primary_id
  mgmt_eni_secondary_id          = module.vpc.mgmt_eni_secondary_id
  wan_eni_secondary_id           = module.vpc.wan_eni_secondary_id
  lan_eni_secondary_id           = module.vpc.lan_eni_secondary_id
  lan_route_table_id             = module.vpc.lan_route_table_id
  site_location                  = var.site_location
  tags                           = var.tags
}