provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

module "vpc" {
  source              = "./1-vpc"
  region              = var.region
  project_name        = var.project_name
  vpc_range           = var.vpc_range
  subnet_range_mgmt   = var.subnet_range_mgmt
  subnet_range_wan    = var.subnet_range_wan
  subnet_range_lan    = var.subnet_range_lan
  mgmt_eni_ip         = var.mgmt_eni_ip
  wan_eni_ip          = var.wan_eni_ip
  lan_eni_ip          = var.lan_eni_ip
  ingress_cidr_blocks = var.ingress_cidr_blocks
}

module "vsocket-aws" {
  source               = "catonetworks/vsocket-aws/cato"
  token                = var.cato_token
  account_id           = var.account_id
  vpc_id               = module.vpc.vpc_id
  key_pair             = var.key_pair
  native_network_range = var.vpc_range
  region               = var.region
  site_name            = "AWS Site ${var.region}"
  site_description     = "AWS Site ${var.region}"
  site_type            = "CLOUD_DC"
  mgmt_eni_id          = module.vpc.mgmt_eni_id
  wan_eni_id           = module.vpc.wan_eni_id
  lan_eni_id           = module.vpc.lan_eni_id
  lan_local_ip         = var.lan_eni_ip
  site_location        = var.site_location
}

# module "WindowsVM" {
#   source        = "../../modules/WindowsVM-AWS"
#   lan_subnet_id = module.vpc.lan_subnet_id
#   vpc_id        = module.vpc.vpc_id
#   region        = var.region
#   key_pair      = var.key_pair
# }

# resource "cato_static_host" "win-host" {
#   site_id = module.vsocket-aws.socket_site_id
#   name    = module.WindowsVM.hostname
#   ip      = module.WindowsVM.private_ip
# }

# ## WAN Firewall Rules - Use Case 3
# module "WAN-Rules" {
#   source                   = "../../modules/WAN-Rules"
#   cato_token               = var.cato_token
#   account_id               = var.account_id
#   site_id                  = module.vsocket-aws.socket_site_id
#   host_id                  = cato_static_host.win-host.id
#   p1_group_name            = "Your User Group Here"
#   p1_device_posture_policy = "Your Device Posture Policy Name Here"
# }

# # ## Internet Firewall Rules - Use Case 5
# module "IFW-Rules" {
#   source     = "../../modules/IFW-Rules"
#   cato_token = var.cato_token
#   account_id = var.account_id
#   ifw_group_names = [
#     { "name" : "Your User Group 1 Here" },
#     { "name" : "Your User Group 2 Here" }
#   ]
#   rbi_category   = "RBI-URLs"
#   block_domains  = ["reddit.com", "www.reddit.com"]
#   prompt_domains = ["espn.com", "www.espn.com"]
#   allow_domains  = ["slashdot.org", "www.slashdot.org"]
# }

