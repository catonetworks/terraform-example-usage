variable "region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_id" {
  description = ""
  type        = string
  default     = null
}

variable "lan_subnet_id" {
  type        = string
  description = "(Required) LAN Subnet ID"
  default     = null
}

variable "key_pair" {
  description = "Name of an existing Key Pair for AWS encryption"
  type        = string
  default     = null
}