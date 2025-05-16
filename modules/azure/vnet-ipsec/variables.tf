variable "az_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
}

variable "site_name" {
  description = "Name of the IPSec site"
  type        = string
}

variable "native_network_range" {
  description = "Native network range for the IPSec site"
  type        = string
}