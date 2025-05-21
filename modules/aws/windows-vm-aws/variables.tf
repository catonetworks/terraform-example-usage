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

variable "build_prod_test_server" { 
  description = "A Boolean of whether to build or not"
  default = false 
  type = bool
}

variable "prod_test_server_private_ip" { 
  description = "Private IP Address of the Test Server"
  type = string 
}

variable "tags" {
  description = "A Map of Keys and Values to describe the infrastructure" 
  type = map() 
  default = null
}