module "vpc" {
  source              = "../../../aws/vpc-vsocket"
  vpc_id              = var.vpc_id
  site_name           = var.site_name
  vpc_range           = var.vpc_range
  subnet_range_mgmt   = var.subnet_range_mgmt == null ? cidrsubnet(var.vpc_range, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan    = var.subnet_range_wan == null ? cidrsubnet(var.vpc_range, 8, 1) : var.subnet_range_wan
  subnet_range_lan    = var.subnet_range_lan == null ? cidrsubnet(var.vpc_range, 8, 2) : var.subnet_range_lan
  mgmt_eni_ip         = var.mgmt_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 0), 5) : var.mgmt_eni_ip
  wan_eni_ip          = var.wan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 1), 5) : var.wan_eni_ip
  lan_eni_ip          = var.lan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 2), 5) : var.lan_eni_ip
  ingress_cidr_blocks = var.ingress_cidr_blocks
}

module "vsocket-aws" {
  source               = "catonetworks/vsocket-aws/cato"
  vpc_id               = module.vpc.vpc_id
  key_pair             = var.key_pair
  native_network_range = var.subnet_range_lan == null ? cidrsubnet(var.vpc_range, 8, 0) : var.subnet_range_lan
  site_name            = var.site_name
  site_description     = var.site_description
  site_type            = var.site_type
  mgmt_eni_id          = module.vpc.mgmt_eni_id
  wan_eni_id           = module.vpc.wan_eni_id
  lan_eni_id           = module.vpc.lan_eni_id
  lan_local_ip         = var.lan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 0), 5) : var.lan_eni_ip
  site_location        = var.site_location
}

