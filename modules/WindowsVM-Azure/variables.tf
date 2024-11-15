## Windows VM Module Variables 
variable "location" { 
  type = string
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  default = null
}

variable "windows-assets-prefix" {
  type = string
  description = "Your asset prefix for resources created"
  default = "windows-demo-vm"
}

variable "resource-group-name" { 
  type = string
  description = "(Required) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."
  default = null
}

variable "lan_subnet_id" { 
  type = string
  description = "(Required) LAN Subnet ID"
  default = null
}

variable "admin_username" {
  type = string
  description = "Admin Username for the VM"
  default = null
}

variable "admin_password" {
  type = string
  description = "Admin Password for the VM"
  default = null
}

