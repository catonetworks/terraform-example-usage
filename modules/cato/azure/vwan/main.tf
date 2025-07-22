# Create Azure Resources
resource "azurerm_resource_group" "azure-rg" {
  location = var.location
  name     = var.azure_resource_group_name
}

resource "azurerm_virtual_wan" "virtualwan" {
  name                = var.az_virtual_wan_name
  resource_group_name = azurerm_resource_group.azure-rg.name
  location            = azurerm_resource_group.azure-rg.location
}

resource "azurerm_virtual_hub" "virtualhub-1" {
  name                = var.az_virtualhub_1_name
  resource_group_name = azurerm_resource_group.azure-rg.name
  location            = var.hub1_location
  virtual_wan_id      = azurerm_virtual_wan.virtualwan.id
  address_prefix      = var.az_virtualhub_1_address_prefix
}

resource "azurerm_virtual_hub" "virtualhub-2" {
  name                = var.az_virtualhub_2_name
  resource_group_name = azurerm_resource_group.azure-rg.name
  location            = var.hub2_location
  virtual_wan_id      = azurerm_virtual_wan.virtualwan.id
  address_prefix      = var.az_virtualhub_2_address_prefix
}

module "cato_azure_vwan_connection-1" {
  source = "catonetworks/azure-vwan/cato"

  cato_api_token            = var.token
  cato_account_id           = var.account_id
  cato_baseurl              = var.baseurl
  azure_resource_group_name = azurerm_resource_group.azure-rg.name
  azure_vwan_name           = azurerm_virtual_wan.virtualwan.name
  azure_hub_name            = azurerm_virtual_hub.virtualhub-1.name
  site_name                 = var.hub1_site_name
  site_description          = var.hub1_site_description
  site_type                 = var.site_type
  primary_cato_pop_ip       = var.primary_cato_pop_ip
  secondary_cato_pop_ip     = var.secondary_cato_pop_ip
  cato_asn                  = var.cato_asn
  azure_asn                 = var.azure_asn
  azure_bgp_peer_weight     = 10
  azure_primary_bgp_ip      = var.hub1_azure_primary_bgp_ip
  cato_primary_bgp_ip       = var.hub1_cato_primary_bgp_ip
  azure_secondary_bgp_ip    = var.hub1_azure_secondary_bgp_ip
  cato_secondary_bgp_ip     = var.hub1_cato_secondary_bgp_ip
  downstream_bw             = var.hub1_downstream_bw
  upstream_bw               = var.hub1_upstream_bw
  tags                      = var.hub1_tags
  depends_on                = [azurerm_resource_group.azure-rg, azurerm_virtual_wan.virtualwan, azurerm_virtual_hub.virtualhub-1, azurerm_virtual_hub.virtualhub-2]
}

module "cato_azure_vwan_connection-2" {
  source                    = "catonetworks/azure-vwan/cato"
  cato_api_token            = var.token
  cato_account_id           = var.account_id
  cato_baseurl              = var.baseurl
  azure_resource_group_name = azurerm_resource_group.azure-rg.name
  azure_vwan_name           = azurerm_virtual_wan.virtualwan.name
  azure_hub_name            = azurerm_virtual_hub.virtualhub-2.name
  site_name                 = var.hub2_site_name
  site_description          = var.hub2_site_description
  site_type                 = var.site_type
  primary_cato_pop_ip       = var.primary_cato_pop_ip
  secondary_cato_pop_ip     = var.secondary_cato_pop_ip
  cato_asn                  = var.cato_asn
  azure_asn                 = var.azure_asn
  azure_bgp_peer_weight     = 10
  azure_primary_bgp_ip      = var.hub2_azure_primary_bgp_ip
  cato_primary_bgp_ip       = var.hub2_cato_primary_bgp_ip
  azure_secondary_bgp_ip    = var.hub2_azure_secondary_bgp_ip
  cato_secondary_bgp_ip     = var.hub2_cato_secondary_bgp_ip
  downstream_bw             = var.hub2_downstream_bw
  upstream_bw               = var.hub2_upstream_bw
  tags                      = var.hub2_tags
  depends_on                = [azurerm_resource_group.azure-rg, azurerm_virtual_wan.virtualwan, azurerm_virtual_hub.virtualhub-1, azurerm_virtual_hub.virtualhub-2]
}