output "resource_group_name" {
  value = azurerm_resource_group.azure-rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.azure-rg.location
}

output "availability_set_name" {
  value = azurerm_availability_set.availability-set.name
}

output "availability_set_id" {
  value = azurerm_availability_set.availability-set.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "subnet_address_prefixes" {
  value = azurerm_subnet.subnet.address_prefixes
}