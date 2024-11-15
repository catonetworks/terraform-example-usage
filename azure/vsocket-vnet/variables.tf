
## Cato Provider Variables
variable "baseurl" {
  description = "Cato API base URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "cato_token" {}

variable "account_id" {
  description = "Account ID"
  type        = number
  default     = null
}

variable "location" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type        = string
  description = "Your Azure Resource Group Name Here"
  default     = null
}

variable "windows-vm-name" {
  type        = string
  description = "Your asset prefix for resources created"
  default     = "windows-demo-vm"
}

variable "assetprefix" {
  type        = string
  description = "Your asset prefix for resources created"
  default     = null
}

variable "site_description" {
  type        = string
  description = "Your site description"
}

variable "site_location" {
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = "New York"
    country_code = "US"
    state_code   = "US-NY" ## Optional - for coutnries with states
    timezone     = "America/New_York"
  }
}

## vSocket Varibables
variable "site_name" {
  type        = string
  description = "Your Cato Site Name Here"
  default     = null
}

variable "site_type" {
  description = "The type of the site"
  type        = string
  default     = "DATACENTER"
  validation {
    condition     = contains(["DATACENTER", "BRANCH", "CLOUD_DC", "HEADQUARTERS"], var.site_type)
    error_message = "The site_type variable must be one of 'DATACENTER','BRANCH','CLOUD_DC','HEADQUARTERS'."
  }
}

variable "vnet_prefix" {
  type        = string
  description = <<EOT
  	Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}

variable "dns_servers" {
  type = list(string)
  default = [
    "10.254.254.1",  # Cato Cloud DNS
    "168.63.129.16", # Azure DNS
    "1.1.1.1",
    "8.8.8.8"
  ]
}

variable "subnet_range_mgmt" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}

variable "subnet_range_wan" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}

variable "subnet_range_lan" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.
    The minimum subnet length to support High Availability is /29.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}

variable "lan_ip" {
  type        = string
  description = "Local IP Address of socket LAN interface"
  default     = null
}

## Windows Credentials
variable "admin_username" {
  type        = string
  description = "Admin Username for the VM"
  default     = null
}

variable "admin_password" {
  type        = string
  description = "Admin Password for the VM"
  default     = null
}

variable "az_location" {
  type        = string
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  default     = null
}

## Internet Firewall Rules Module
variable "rbi_category" {
  type        = string
  description = "List of block categories"
  default     = "Unsanctioned"
}

variable "block_domains" {
  type        = list(string)
  description = "List of block domains"
  default     = []
}

variable "prompt_domains" {
  type        = list(string)
  description = "List of prompt domains"
  default     = []
}

variable "allow_domains" {
  type        = list(string)
  description = "List of allow domains"
  default     = []
}

