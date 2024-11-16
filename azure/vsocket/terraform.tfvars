location              = "East US"
windows-vm-name       = "WIN-DEMO-VM"
site_name             = "Azure_Socket_Site"
vnet_prefix           = "10.30.0.0/16"
subnet_range_mgmt     = "10.30.1.0/24"
subnet_range_wan      = "10.30.2.0/24"
subnet_range_lan      = "10.30.3.0/24"
lan_ip                = "10.30.3.4"
site_description      = "Azure Socket Site East US"
site_location = {
  city         = "New York"
  country_code = "US"
  state_code   = "US-NY" ## Optional - for coutnries with states
  timezone     = "America/New_York"
}
admin_username = "catouser"
admin_password = "Your@Password@here"