module "vpc" {
  source           = "../../../gcp/vpc-vsocket"
  network_tier     = var.network_tier
  site_name        = var.site_name
  subnet_mgmt_cidr = var.subnet_mgmt_cidr == null ? cidrsubnet(var.vpc_range, 8, 0) : var.subnet_mgmt_cidr
  subnet_wan_cidr  = var.subnet_wan_cidr == null ? cidrsubnet(var.vpc_range, 8, 1) : var.subnet_wan_cidr
  subnet_lan_cidr  = var.subnet_lan_cidr == null ? cidrsubnet(var.vpc_range, 8, 2) : var.subnet_lan_cidr
  public_ip_mgmt   = var.public_ip_mgmt
  public_ip_wan    = var.public_ip_wan
  region           = var.region
}

module "vsocket-gcp" {
  depends_on = [module.vpc]
  # source                   = "catonetworks/vsocket-gcp/cato"  
  source                   = "../../../../../terraform-cato-vsocket-gcp"
  allowed_ports            = var.allowed_ports
  boot_disk_size           = var.boot_disk_size
  create_firewall_rule     = var.create_firewall_rule
  wan_firewall_rule_name   = var.wan_firewall_rule_name
  mgmt_compute_network_id  = module.vpc.vpc_mgmt_id
  wan_compute_network_id   = module.vpc.vpc_wan_id
  lan_compute_network_id   = module.vpc.vpc_lan_id
  mgmt_subnet_id           = module.vpc.subnet_mgmt_id
  wan_subnet_id            = module.vpc.subnet_wan_id
  lan_subnet_id            = module.vpc.subnet_lan_id
  mgmt_network_ip          = var.mgmt_network_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 0), 5) : var.mgmt_network_ip
  wan_network_ip           = var.wan_network_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 1), 5) : var.wan_network_ip
  lan_network_ip           = var.lan_network_ip == null ? cidrhost(cidrsubnet(var.vpc_range, 8, 2), 5) : var.lan_network_ip
  native_network_range     = var.subnet_lan_cidr == null ? cidrsubnet(var.vpc_range, 8, 2) : var.subnet_lan_cidr
  management_source_ranges = var.management_source_ranges
  mgmt_static_ip_address   = module.vpc.ip_mgmt_address
  wan_static_ip_address    = module.vpc.ip_wan_address
  zone                     = var.zone
  site_name                = var.site_name
  site_description         = var.site_description
  site_location            = var.site_location
  tags                     = var.tags
  labels                   = var.labels
}