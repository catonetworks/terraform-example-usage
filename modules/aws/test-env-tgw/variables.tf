variable "site_name" {
  description = "Name of the vsocket site"
  type        = string
}


variable "tags" {
  description = "A Map of Key Values which describe the infrastructure"
}

variable "native_network_range" {
  description = "CIDR block for native subnet inside the vSocket"
  type        = string
}

variable "tgw_id" {
  description = "The ID of the transit gateway to use"
  type        = string
}

variable "vpc1_cidr_block" {
  description = "The CIDR Block for VPC1 Test VPC"
  default     = null
}

variable "vpc2_cidr_block" {
  description = "The CIDR Block for VPC2 Test VPC"
  default     = null
}

variable "vpc3_cidr_block" {
  description = "The CIDR Block for VPC3 Test VPC"
  default     = null
}

variable "vpc1_enable_nat_gateway" {
  description = "Whether to Enable the NAT Gateway in Test VPC 1"
  default     = false
}

variable "vpc2_enable_nat_gateway" {
  description = "Whether to Enable the NAT Gateway in Test VPC 2"
  default     = false
}

variable "vpc3_enable_nat_gateway" {
  description = "Whether to Enable the NAT Gateway in Test VPC 3"
  default     = false
}

variable "vpc1_enable_dns_support" {
  description = "Whether to enable DNS Support in Test VPC 1"
  default     = true
}

variable "vpc2_enable_dns_support" {
  description = "Whether to enable DNS Support in Test VPC 2"
  default     = true
}

variable "vpc3_enable_dns_support" {
  description = "Whether to enable DNS Support in Test VPC 3"
  default     = true
}

variable "keypair_name" {
  description = "KeyPair for use on all Machines"
}

variable "external_testing_range" {
  description = "IP Address for Remote Access to Externally Faced Servers"
  default     = null
}

variable "enable_kali" {
  description = "Enable build of Kali Instances"
  default     = false
}

variable "kali_ami_id" {
  description = "Custom AMI for Kali"
  default     = null
}