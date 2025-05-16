provider "azurerm" {
  features {}
}

# Create Network Interfaces
resource "azurerm_network_interface" "lan-nic" {
  location            = var.location
  name                = "${var.windows-assets-prefix}-LAN"
  resource_group_name = var.resource-group-name
  ip_configuration {
    name                          = "LAN-IP"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.lan_subnet_id
  }
}

# Create a Windows Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.windows-assets-prefix
  location              = var.location
  resource_group_name   = var.resource-group-name
  network_interface_ids = [azurerm_network_interface.lan-nic.id]
  vm_size               = "Standard_D4S_v3"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "17763.6189.240811"
  }

  storage_os_disk {
    name              = "winosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.windows-assets-prefix
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  tags = {
    environment = var.windows-assets-prefix
  }
}

resource "azurerm_managed_disk" "win-disk" {
  name                 = "${var.windows-assets-prefix}-win-osdisk"
  location             = var.location
  resource_group_name  = var.resource-group-name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 127
}

resource "azurerm_virtual_machine_data_disk_attachment" "win-disk-attachment" {
  managed_disk_id    = azurerm_managed_disk.win-disk.id
  virtual_machine_id = azurerm_virtual_machine.vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_network_security_group" "windows" {
  name                = replace("${var.windows-assets-prefix}SecurityGroup", "-", "")
  location            = var.location
  resource_group_name = var.resource-group-name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.windows-assets-prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "windows" {
  subnet_id                 = var.lan_subnet_id
  network_security_group_id = azurerm_network_security_group.windows.id
}

