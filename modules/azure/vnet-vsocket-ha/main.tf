## VNET Module Resources
resource "azurerm_resource_group" "azure-rg" {
  location = var.location
  name     = replace(replace(var.site_name, "-", "_"), " ", "_")
}

resource "azurerm_availability_set" "availability-set" {
  location                     = var.location
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
  address_space       = [var.vnet_prefix]
  location            = var.location
  name                = replace(replace("${var.site_name}-vsNet", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_virtual_network_dns_servers" "dns_servers" {
  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "subnet-mgmt" {
  address_prefixes     = [var.subnet_range_mgmt]
  name                 = replace(replace("${var.site_name}-subnetMGMT", "-", "_"), " ", "_")
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = replace(replace("${var.site_name}-vsNet", "-", "_"), " ", "_")
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_subnet" "subnet-wan" {
  address_prefixes     = [var.subnet_range_wan]
  name                 = replace(replace("${var.site_name}-subnetWAN", "-", "_"), " ", "_")
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = replace(replace("${var.site_name}-vsNet", "-", "_"), " ", "_")
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_subnet" "subnet-lan" {
  address_prefixes     = [var.subnet_range_lan]
  name                 = replace(replace("${var.site_name}-subnetLAN", "-", "_"), " ", "_")
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = replace(replace("${var.site_name}-vsNet", "-", "_"), " ", "_")
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Allocate Public IPs
resource "azurerm_public_ip" "mgmt-public-ip-primary" {
  allocation_method   = "Static"
  location            = var.location
  name                = replace(replace("${var.site_name}-mngPublicIPPrimary", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_public_ip" "wan-public-ip-primary" {
  allocation_method   = "Static"
  location            = var.location
  name                = replace(replace("${var.site_name}-wanPublicIPPrimary", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_public_ip" "mgmt-public-ip-secondary" {
  allocation_method   = "Static"
  location            = var.location
  name                = replace(replace("${var.site_name}-mngPublicIPSecondary", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_public_ip" "wan-public-ip-secondary" {
  allocation_method   = "Static"
  location            = var.location
  name                = replace(replace("${var.site_name}-wanPublicIPSecondary", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

# Create Network Interfaces
resource "azurerm_network_interface" "mgmt-nic-primary" {
  location            = var.location
  name                = "${var.site_name}-mngPrimary"
  resource_group_name = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-mgmtIPPrimary", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mgmt-public-ip-primary.id
    subnet_id                     = azurerm_subnet.subnet-mgmt.id
  }
  depends_on = [
    azurerm_public_ip.mgmt-public-ip-primary,
    azurerm_subnet.subnet-mgmt
  ]
}

resource "azurerm_network_interface" "wan-nic-primary" {
  ip_forwarding_enabled = true
  location              = var.location
  name                  = "${var.site_name}-wanPrimary"
  resource_group_name   = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-wanIPPrimary", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wan-public-ip-primary.id
    subnet_id                     = azurerm_subnet.subnet-wan.id
  }
  depends_on = [
    azurerm_public_ip.wan-public-ip-primary,
    azurerm_subnet.subnet-wan
  ]
}

resource "azurerm_network_interface" "lan-nic-primary" {
  ip_forwarding_enabled = true
  location              = var.location
  name                  = "${var.site_name}-lanPrimary"
  resource_group_name   = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-lanIPConfigPrimary", "-", "_"), " ", "_")
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lan_ip_primary
    subnet_id                     = azurerm_subnet.subnet-lan.id
  }
  depends_on = [
    azurerm_subnet.subnet-lan
  ]
}

resource "azurerm_network_interface" "mgmt-nic-secondary" {
  location            = var.location
  name                = "${var.site_name}-mngSecondary"
  resource_group_name = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-mgmtIPSecondary", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mgmt-public-ip-secondary.id
    subnet_id                     = azurerm_subnet.subnet-mgmt.id
  }
  depends_on = [
    azurerm_public_ip.mgmt-public-ip-secondary,
    azurerm_subnet.subnet-mgmt
  ]
}

resource "azurerm_network_interface" "wan-nic-secondary" {
  ip_forwarding_enabled = true
  location              = var.location
  name                  = "${var.site_name}-wanSecondary"
  resource_group_name   = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-wanIPSecondary", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wan-public-ip-secondary.id
    subnet_id                     = azurerm_subnet.subnet-wan.id
  }
  depends_on = [
    azurerm_public_ip.wan-public-ip-secondary,
    azurerm_subnet.subnet-wan
  ]
}

resource "azurerm_network_interface" "lan-nic-secondary" {
  ip_forwarding_enabled = true
  location              = var.location
  name                  = "${var.site_name}-lanSecondary"
  resource_group_name   = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-lanIPConfigSecondary", "-", "_"), " ", "_")
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lan_ip_secondary
    subnet_id                     = azurerm_subnet.subnet-lan.id
  }
  depends_on = [
    azurerm_subnet.subnet-lan
  ]
}

resource "azurerm_subnet_network_security_group_association" "mgmt-association" {
  subnet_id                 = azurerm_subnet.subnet-mgmt.id
  network_security_group_id = azurerm_network_security_group.mgmt-sg.id
}

resource "azurerm_subnet_network_security_group_association" "wan-association" {
  subnet_id                 = azurerm_subnet.subnet-wan.id
  network_security_group_id = azurerm_network_security_group.wan-sg.id
}

resource "azurerm_subnet_network_security_group_association" "lan-association" {
  subnet_id                 = azurerm_subnet.subnet-lan.id
  network_security_group_id = azurerm_network_security_group.lan-sg.id
}

# Create Security Groups
resource "azurerm_network_security_group" "mgmt-sg" {
  location            = var.location
  name                = replace(replace("${var.site_name}-MGMTSecurityGroup", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}
resource "azurerm_network_security_group" "wan-sg" {
  location            = var.location
  name                = replace(replace("${var.site_name}-WANSecurityGroup", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_network_security_group" "lan-sg" {
  location            = var.location
  name                = replace(replace("${var.site_name}-LANSecurityGroup", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

## Create Route Tables, Routes and Associations 
resource "azurerm_route_table" "private-rt" {
  bgp_route_propagation_enabled = false
  location                      = var.location
  name                          = replace(replace("${var.site_name}-viaCato", "-", "_"), " ", "_")
  resource_group_name           = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_route" "public-rt" {
  address_prefix      = "23.102.135.246/32" #
  name                = "Microsoft-KMS"
  next_hop_type       = "Internet"
  resource_group_name = azurerm_resource_group.azure-rg.name
  route_table_name    = replace(replace("${var.site_name}-viaCato", "-", "_"), " ", "_")
  depends_on = [
    azurerm_route_table.private-rt
  ]
}

resource "azurerm_route" "lan-route" {
  address_prefix         = "0.0.0.0/0"
  name                   = "default-cato"
  next_hop_in_ip_address = var.floating_ip
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = azurerm_resource_group.azure-rg.name
  route_table_name       = replace(replace("${var.site_name}-viaCato", "-", "_"), " ", "_")
  depends_on = [
    azurerm_route_table.private-rt
  ]
}

resource "azurerm_route_table" "public-rt" {
  bgp_route_propagation_enabled = false
  location                      = var.location
  name                          = replace(replace("${var.site_name}-viaInternet", "-", "_"), " ", "_")
  resource_group_name           = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_route" "route-internet" {
  address_prefix      = "0.0.0.0/0"
  name                = "default-internet"
  next_hop_type       = "Internet"
  resource_group_name = azurerm_resource_group.azure-rg.name
  route_table_name    = replace(replace("${var.site_name}-viaInternet", "-", "_"), " ", "_")
  depends_on = [
    azurerm_route_table.public-rt
  ]
}

resource "azurerm_subnet_route_table_association" "rt-table-association-mgmt" {
  route_table_id = azurerm_route_table.public-rt.id
  subnet_id      = azurerm_subnet.subnet-mgmt.id
  depends_on = [
    azurerm_route_table.public-rt,
    azurerm_subnet.subnet-mgmt
  ]
}

resource "azurerm_subnet_route_table_association" "rt-table-association-wan" {
  route_table_id = azurerm_route_table.public-rt.id
  subnet_id      = azurerm_subnet.subnet-wan.id
  depends_on = [
    azurerm_route_table.public-rt,
    azurerm_subnet.subnet-wan,
  ]
}

resource "azurerm_subnet_route_table_association" "rt-table-association-lan" {
  route_table_id = azurerm_route_table.private-rt.id
  subnet_id      = azurerm_subnet.subnet-lan.id
  depends_on = [
    azurerm_route_table.private-rt,
    azurerm_subnet.subnet-lan
  ]
}