output "private_ip" { value = azurerm_network_interface.lan-nic.private_ip_address }
output "hostname" { value = azurerm_virtual_machine.vm.name }