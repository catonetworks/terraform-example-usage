# Azure region where resources will be created
az_location = "East US"
resource_group_name = "cato-rg"
vnet_name = "cato-vnet"
gateway_subnet_name = "GatewaySubnet"
vpn_gateway_name = "azure-vpn-gateway"
local_network_gateway_name = "cato-local-network-gateway"
site_name = "Azure-Cato-IPSec-Site"
site_description = "Azure Cato IPSec Site"
native_network_range = "172.16.0.0/24"
primary_private_cato_ip = "169.1.1.1"
primary_private_site_ip = "169.1.1.2"
secondary_private_cato_ip = "169.2.1.1"
secondary_private_site_ip = "169.2.1.2"
downstream_bw = 100
upstream_bw = 100
site_location = {
  city         = "New York City"
  country_code = "US"
  state_code   = "US-NY" ## Optional - for countries with states
  timezone     = "America/New_York"
}

# IP address and ID of Cato public allocated IP from POP for the primary tunnel (replace with the desired values)
primary_cato_pop_ip   = "22.33.44.55"
primary_public_cato_ip_id = "17015"

# IP address and ID of Cato public allocated IP from POP for the secondary tunnel (replace with the desired values)
secondary_cato_pop_ip = "22.33.44.66"
secondary_public_cato_ip_id = "22712"
