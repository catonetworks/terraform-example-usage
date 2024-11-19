provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

## vSocket Module Resources
provider "azurerm" {
  features {}
}

# !!!!! DEPENDENCY !!!!! 
# Create 2 allocated IPs in Cato Management Application(CMA), retrieve the IPs and the IDs via API/CLI
# The IPs will be used for the primary and secondary tunnels
# https://support.catonetworks.com/hc/en-us/articles/4413273467153-Allocating-IP-Addresses-for-the-Account

# Create Azure resources first
resource "azurerm_resource_group" "azure-rg" {
  location = var.az_location
  name     = replace(replace("${var.site_name}-VNET", "-", ""), " ", "_")
}

resource "azurerm_availability_set" "availability-set" {
  location                     = var.az_location
  name                         = replace(replace("${var.site_name}-availabilitySet", "-", "_"), " ", "_")
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  resource_group_name          = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

## Create Network and Subnets
resource "azurerm_virtual_network" "vnet" {
  address_space       = [var.native_network_range]
  location            = var.az_location
  name                = replace(replace("${var.site_name}-vsNet", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_subnet" "subnet" {
  address_prefixes     = [var.native_network_range]
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = replace(replace("${var.site_name}-vsNet", "-", "_"), " ", "_")
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}


module "ipsec-azure" {
  source                      = "catonetworks/ipsec-azure/cato"
  token                       = var.cato_token
  account_id                  = var.account_id
  resource_group_name         = var.resource_group_name
  vnet_name                   = azurerm_virtual_network.vnet.name
  az_location                 = var.az_location
  vpn_gateway_name            = var.vpn_gateway_name
  site_name                   = var.site_name
  site_description            = var.site_description
  native_network_range        = var.native_network_range
  local_network_gateway_name  = var.local_network_gateway_name
  site_location               = var.site_location
  primary_cato_pop_ip         = var.primary_cato_pop_ip
  secondary_cato_pop_ip       = var.secondary_cato_pop_ip
  primary_public_cato_ip_id   = var.primary_public_cato_ip_id
  primary_private_cato_ip     = var.primary_private_cato_ip
  primary_private_site_ip     = var.primary_private_site_ip
  secondary_public_cato_ip_id = var.secondary_public_cato_ip_id
  secondary_private_cato_ip   = var.secondary_private_cato_ip
  secondary_private_site_ip   = var.secondary_private_site_ip
  downstream_bw               = var.downstream_bw
  upstream_bw                 = var.upstream_bw
  gateway_subnet_id           = azurerm_subnet.subnet.id
}
