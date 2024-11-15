provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

# ## Create Cato SocketSite and Deploy Vsocket
module "vsocket-azure" {
  # source              = "../../../terraform-cato-vsocket-azure-vnet"
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
  resource-group-name   = module.vsocket-azure.resource_group_name
  windows-assets-prefix = "windows-vm-VNET"
  lan_subnet_id         = module.vsocket-azure.lan_subnet_id
  admin_username        = var.admin_username
  admin_password        = var.admin_password
}

resource "cato_static_host" "win-host" {
  site_id     = module.vsocket-azure.socket_site_id
  name        = module.WindowsVM.hostname
  ip          = module.WindowsVM.private_ip
}

# ## Internet Firewall Rules
module "IFW-Rules" {
  source         = "../../modules/IFW-Rules"
  cato_token     = var.cato_token 
  account_id     = var.account_id
  rbi_category   = "Unsanctioned"
  block_domains  = ["reddit.com", "www.reddit.com"]
  prompt_domains = ["espn.com", "www.espn.com"]
  allow_domains  = ["slashdot.org", "www.slashdot.org"]
}

# ## WAN Firewall Rules
# module "WAN-Rules" {
#   source                = "../../modules/WAN-Rules"
# }
