variable "site_name" {
  description = "Name of the vsocket site"
  type        = string
  default     = "GCP-Cato-vSocket"
}

variable "site_description" {
  description = "Description of the vsocket site"
  type        = string
  default     = "GCP Cato vSocket"
}

variable "site_location" {
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = "New York City"
    country_code = "US"
    state_code   = "US-NY" ## Optional - for coutnries with states
    timezone     = "America/New_York"
  }
}

# Variables
variable "region" {
  description = "GCP Region"
  type        = string
  default     = "me-west1"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "Region must be in the format: region-location (e.g., us-central1)."
  }
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "me-west1-a"
}

variable "vpc_range" {
  description = <<EOT
  	Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  type        = string
  default     = "10.100.0.0/16"
}

variable "subnet_mgmt_cidr" {
  description = "Management Subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_wan_cidr" {
  description = "WAN Subnet CIDR"
  type        = string
  default     = null
}

variable "subnet_lan_cidr" {
  description = "LAN Subnet CIDR"
  type        = string
  default     = null
}

variable "boot_disk_size" {
  description = "Boot disk size in GB (minimum 10 GB)"
  type        = number
  default     = 20
  validation {
    condition     = var.boot_disk_size >= 10
    error_message = "Boot disk size must be at least 10 GB."
  }
}

variable "network_tier" {
  description = "Network tier for the public IP"
  type        = string
  default     = "STANDARD"
}

variable "mgmt_network_ip" {
  description = "Management network IP"
  type        = string
  # validation {
  #   condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.mgmt_network_ip))
  #   error_message = "Management network IP must be a valid IPv4 address."
  # }
  default = null
}

variable "wan_network_ip" {
  description = "WAN network IP"
  type        = string
  # validation {
  #   condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.wan_network_ip))
  #   error_message = "WAN network IP must be a valid IPv4 address."
  # }
  default = null
}

variable "lan_network_ip" {
  description = "LAN network IP"
  type        = string
  # validation {
  #   condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.lan_network_ip))
  #   error_message = "LAN network IP must be a valid IPv4 address."
  # }
  default = null
}

variable "public_ip_mgmt" {
  description = "Whether to assign the existing static IP to management interface. If false, no public IP will be assigned."
  type        = bool
  default     = true
}

variable "public_ip_wan" {
  description = "Whether to assign the existing static IP to WAN interface. If false, no public IP will be assigned."
  type        = bool
  default     = true
}

# Firewall Configuration
variable "wan_firewall_rule_name" {
  # Only used if create_firewall_rule = true
  description = "Name of the firewall rule (1-63 chars, lowercase letters, numbers, or hyphens)"
  type        = string
  # validation {
  #   condition     = can(regex("^[a-z][a-z0-9-]{0,61}[a-z0-9]$", var.wan_firewall_rule_name))
  #   error_message = "Firewall rule name must be 1-63 characters, start with a letter, and contain only lowercase letters, numbers, or hyphens."
  # }
  default = "allow-management-access"
}

variable "allowed_ports" {
  # Only used if create_firewall_rule = true
  description = "List of ports to allow through the firewall (Required)"
  type        = list(string)
  # validation {
  #   condition     = length(var.allowed_ports) > 0
  #   error_message = "At least one port must be specified."
  # }
  default = null
}

variable "management_source_ranges" {
  # Only used if create_firewall_rule = true
  description = "Source IP ranges that can access the instance via SSH/HTTPS (Required)"
  type        = list(string)
  # validation {
  #   condition     = length(var.management_source_ranges) > 0
  #   error_message = "At least one source IP range must be provided for management access."
  # }
  default = [] # Replace with your IP range
}

variable "create_firewall_rule" {
  description = "Whether to create the firewall rule for management access"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels to be appended to GCP resources"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to be appended to GCP resources"
  type        = list(string)
  default     = []
}