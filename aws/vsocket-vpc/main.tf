module "vsocket-aws-vpc" {
  source               = "catonetworks/vsocket-aws-vpc/cato"
  token                = var.cato_token
  account_id           = var.account_id
  region               = var.region
  native_network_range = var.vpc_range
  subnet_range_mgmt    = var.subnet_range_mgmt
  subnet_range_wan     = var.subnet_range_wan
  subnet_range_lan     = var.subnet_range_lan
  mgmt_eni_ip          = var.mgmt_eni_ip
  wan_eni_ip           = var.wan_eni_ip
  lan_eni_ip           = var.lan_eni_ip
  ingress_cidr_blocks  = var.ingress_cidr_blocks
  key_pair             = var.key_pair
  site_name            = var.site_name
  site_description     = var.site_description
  site_location        = var.site_location
}

module "WindowsVM" {
  source        = "../../modules/WindowsVM-AWS"
  lan_subnet_id = module.vsocket-aws-vpc.lan_subnet_id
  vpc_id        = module.vsocket-aws-vpc.vpc_id
  region        = var.region
  key_pair      = var.key_pair
}

module "WindowsVM" {
  source        = "../../modules/WindowsVM-AWS"
  lan_subnet_id = module.vpc.lan_subnet_id
  vpc_id        = module.vpc.vpc_id
  region        = var.region
  key_pair      = var.key_pair
}

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

