provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

# ## Create Cato SocketSite and Deploy Vsocket
module "vsocket-azure" {
  source              = "catonetworks/vsocket-azure-vnet/cato"
  token               = var.cato_token
  account_id          = var.account_id
  vnet_prefix         = var.vnet_prefix
  subnet_range_mgmt   = var.subnet_range_mgmt
  subnet_range_wan    = var.subnet_range_wan
  subnet_range_lan    = var.subnet_range_lan
  dns_servers         = var.dns_servers
  lan_ip              = var.lan_ip
  resource-group-name = var.resource_group_name
  site_name           = var.site_name
  site_description    = var.site_description
  site_type           = var.site_type
  site_location       = var.site_location
  az_location         = var.location
}

## Create Windows VM on LAN
module "WindowsVM" {
  source                = "../../modules/WindowsVM-Azure"
  location              = var.location
  resource-group-name   = module.vnet.resource-group-name
  windows-assets-prefix = var.windows-vm-name
  lan_subnet_id         = module.vnet.lan_subnet_id
  admin_username        = var.admin_username
  admin_password        = var.admin_password
}

resource "cato_static_host" "win-host" {
  site_id = module.vsocket-azure.socket_site_id
  name    = module.WindowsVM.hostname
  ip      = module.WindowsVM.private_ip
}

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

