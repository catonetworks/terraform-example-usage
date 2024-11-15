# Cato Variables
variable "baseurl" {
  description = "Cato Networks API URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "cato_token" {
  description = "Cato Networks API Token"
  type        = string
  #sensitive   = true
}

variable "account_id" {
  description = "Account ID"
  type        = number
  default     = null
}

## WAN Firewall Rules Module
variable "site_id" {
  type        = string
  description = "ID of site"
  default     = null
}

variable "host_id" {
  type        = string
  description = "ID of host"
  default     = null
}

variable "p1_group_name" {
  type        = string
  description = "Name of group"
  default     = null
}

variable "p1_device_posture_policy" {
  type        = string
  description = "Device posture policy"
  default     = null
}

variable "p2_group_name" {
  type        = string
  description = "Name of group"
  default     = null
}

variable "p2_device_posture_policy" {
  type        = string
  description = "Device posture policy"
  default     = null
}