resource "azurerm_resource_group" "azure-rg" {
  location = var.az_location
  name     = replace(replace("${var.site_name}_rg", "-", "_"), " ", "_")
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