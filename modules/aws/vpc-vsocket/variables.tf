## VPC Variables
variable "region" {
  type    = string
  default = "us-east-2"
}

variable "site_name" {
  type    = string
  default = null
}

variable "ingress_cidr_blocks" {
  type    = list(any)
  default = null
}

variable "subnet_range_mgmt" {
  type    = string
  default = null
}

variable "subnet_range_wan" {
  type    = string
  default = null
}

variable "subnet_range_lan" {
  type    = string
  default = null
}

variable "vpc_range" {
  type    = string
  default = null
}

variable "mgmt_eni_ip" {
  description = "Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "wan_eni_ip" {
  description = "Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "lan_eni_ip" {
  description = "Choose an IP Address within the LAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = ""
  type        = string
  default     = null
}

