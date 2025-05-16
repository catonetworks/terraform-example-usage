module "vsocket-aws-vpc" {
  source               = "catonetworks/vsocket-aws-vpc/cato"
  native_network_range = var.vpc_range
  vpc_network_range    = var.vpc_range
  subnet_range_mgmt    = var.subnet_range_mgmt == null ? cidrsubnet(var.vpc_range, 8, 0) : var.subnet_range_mgmt
  subnet_range_wan     = var.subnet_range_wan == null ? cidrsubnet(var.vpc_range, 8, 1) : var.subnet_range_wan
  subnet_range_lan     = var.subnet_range_lan == null ? cidrsubnet(var.vpc_range, 8, 2) : var.subnet_range_lan
  mgmt_eni_ip          = var.mgmt_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 0), 5) : var.mgmt_eni_ip
  wan_eni_ip           = var.wan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 1), 5) : var.wan_eni_ip
  lan_eni_ip           = var.lan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 2), 5) : var.lan_eni_ip
  ingress_cidr_blocks  = var.ingress_cidr_blocks
  key_pair             = var.key_pair
  site_name            = var.site_name
  site_description     = var.site_description
  site_location        = var.site_location
}