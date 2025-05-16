## VNET Module Resources
resource "azurerm_resource_group" "azure-rg" {
  location = var.location
  name     = replace(replace("${var.site_name}_rg", "-", "_"), " ", "_")
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
resource "azurerm_public_ip" "mgmt-public-ip" {
  allocation_method   = "Static"
  location            = var.location
  name                = replace(replace("${var.site_name}-vs0nicMngPublicIP", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_public_ip" "wan-public-ip" {
  allocation_method   = "Static"
  location            = var.location
  name                = replace(replace("${var.site_name}-vs0nicWanPublicIP", "-", "_"), " ", "_")
  resource_group_name = azurerm_resource_group.azure-rg.name
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

# Create Network Interfaces
resource "azurerm_network_interface" "mgmt-nic" {
  location            = var.location
  name                = "${var.site_name}-vs0nicMng"
  resource_group_name = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-vs0nicMngIP", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mgmt-public-ip.id
    subnet_id                     = azurerm_subnet.subnet-mgmt.id
  }
  depends_on = [
    azurerm_public_ip.mgmt-public-ip,
    azurerm_subnet.subnet-mgmt
  ]
}

resource "azurerm_network_interface" "wan-nic" {
  ip_forwarding_enabled = true
  location              = var.location
  name                  = "${var.site_name}-vs0nicWan"
  resource_group_name   = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-vs0nicWanIP", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wan-public-ip.id
    subnet_id                     = azurerm_subnet.subnet-wan.id
  }
  depends_on = [
    azurerm_public_ip.wan-public-ip,
    azurerm_subnet.subnet-wan
  ]
}

resource "azurerm_network_interface" "lan-nic" {
  ip_forwarding_enabled = true
  location              = var.location
  name                  = "${var.site_name}-vs0nicLan"
  resource_group_name   = azurerm_resource_group.azure-rg.name
  ip_configuration {
    name                          = replace(replace("${var.site_name}-lanIPConfig", "-", "_"), " ", "_")
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet-lan.id
  }
  depends_on = [
    azurerm_subnet.subnet-lan
  ]
}

resource "azurerm_network_interface_security_group_association" "mgmt-nic-association" {
  network_interface_id      = azurerm_network_interface.mgmt-nic.id
  network_security_group_id = azurerm_network_security_group.mgmt-sg.id
  depends_on = [
    azurerm_network_interface.mgmt-nic,
    azurerm_network_security_group.mgmt-sg
  ]
}

resource "azurerm_network_interface_security_group_association" "wan-nic-association" {
  network_interface_id      = azurerm_network_interface.wan-nic.id
  network_security_group_id = azurerm_network_security_group.wan-sg.id
  depends_on = [
    azurerm_network_interface.wan-nic,
    azurerm_network_security_group.wan-sg
  ]
}

resource "azurerm_network_interface_security_group_association" "lan-nic-association" {
  network_interface_id      = azurerm_network_interface.lan-nic.id
  network_security_group_id = azurerm_network_security_group.lan-sg.id
  depends_on = [
    azurerm_network_interface.lan-nic,
    azurerm_network_security_group.lan-sg
  ]
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
  address_prefix      = var.azure_kms_ip
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
  name                   = "default"
  next_hop_in_ip_address = var.lan_ip
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = azurerm_resource_group.azure-rg.name
  route_table_name       = replace(replace("${var.site_name}-viaCato", "-", "_"), " ", "_")
  depends_on = [
    azurerm_route_table.private-rt
  ]
}

resource "azurerm_route_table" "public-rt" {
  bgp_route_propagation_enabled = true
  location                      = var.location
  name                          = replace(replace("${var.site_name}-viaInternet", "-", "_"), " ", "_")
  resource_group_name           = azurerm_resource_group.azure-rg.name
  depends_on = [
    azurerm_resource_group.azure-rg
  ]
}

resource "azurerm_route" "route-internet" {
  address_prefix      = "0.0.0.0/0"
  name                = "default"
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

