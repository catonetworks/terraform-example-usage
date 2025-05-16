variable "site_name" {
  description = "Name of the vsocket site"
  type        = string
}

variable "subnet_mgmt_cidr" {
  description = "Management Subnet CIDR"
  type        = string
}

variable "subnet_wan_cidr" {
  description = "WAN Subnet CIDR"
  type        = string
}

variable "subnet_lan_cidr" {
  description = "LAN Subnet CIDR"
  type        = string
}

# Variables
variable "region" {
  description = "GCP Region"
  type        = string
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "Region must be in the format: region-location (e.g., us-central1)."
  }
}

variable "public_ip_wan" {
  description = "Whether to assign the existing static IP to WAN interface. If false, no public IP will be assigned."
  type        = bool
}

variable "network_tier" {
  description = "Network tier for the public IP"
  type        = string
}

variable "public_ip_mgmt" {
  description = "Whether to assign the existing static IP to management interface. If false, no public IP will be assigned."
  type        = bool
}
