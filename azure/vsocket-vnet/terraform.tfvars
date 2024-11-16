# Azure vSocket Module Variables
location              = "East US"
site_name             = "Azure_Socket_Site"
vnet_prefix           = "10.40.0.0/16"
subnet_range_mgmt     = "10.40.1.0/24"
subnet_range_wan      = "10.40.2.0/24"
subnet_range_lan      = "10.40.3.0/24"
lan_ip                = "10.40.3.4"
site_description      = "Azure Socket Site East US"
site_location = {
  city         = "New York"
  country_code = "US"
  state_code   = "US-NY" ## Optional - for coutnries with states
  timezone     = "America/New_York"
}

# Azure Windows Module Variables
windows-vm-name = "WIN-DEMO-VM-VNET"
admin_username = "catouser"
admin_password = "Your@Password@here"

# Internet Firewall Module Variables
rbi_category   = "Unsanctioned"
block_domains  = ["reddit.com", "www.reddit.com"]
prompt_domains = ["espn.com", "www.espn.com"]
allow_domains  = ["slashdot.org", "www.slashdot.org"]

