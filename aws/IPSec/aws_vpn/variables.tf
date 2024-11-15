variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
}

variable "bgp_asn" {
  description = "BGP ASN for the customer gateway"
  type        = number
}

variable "cgw_ip" {
  description = "Public IP address for the customer gateway"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the VPN gateway will be attached"
  type        = string
}
