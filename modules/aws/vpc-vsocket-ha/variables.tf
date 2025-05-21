## VPC Variables
variable "site_name" {
  description = "Name of the vsocket site"
  type        = string
  default     = "AWS-Cato-vSocket-HA-Site"
}

variable "ingress_cidr_blocks" {
  type        = list(any)
  description = <<EOT
  	Set CIDR to receive traffic from the specified IPv4 CIDR address ranges
	For example x.x.x.x/32 to allow one specific IP address access, 0.0.0.0/0 to allow all IP addresses access, or another CIDR range
    Best practice is to allow a few IPs as possible
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT  
  default     = ["0.0.0.0/0"]
}

variable "subnet_range_mgmt" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_wan" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_lan_primary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the private LAN subnet for the primary vsocket. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_lan_secondary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the private LAN subnet for the secondary vsocket.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "vpc_range" {
  type        = string
  description = <<EOT
  	Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = "10.1.0.0/16"
}

variable "mgmt_eni_primary_ip" {
  description = "Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "wan_eni_primary_ip" {
  description = "Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "lan_eni_primary_ip" {
  description = "Choose an IP Address within the LAN Subnet for the Primary lan interface. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
}

variable "mgmt_eni_secondary_ip" {
  description = "Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
}

variable "wan_eni_secondary_ip" {
  description = "Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "lan_eni_secondary_ip" {
  description = "Choose an IP Address within the LAN Subnet for the Secondary lan interface. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "Specify a VPC ID to use. If not specified, a new VPC will be created."
  type        = string
  default     = null
}

variable "internet_gateway_id" {
  description = "Specify an Internet Gateway ID to use. If not specified, a new Internet Gateway will be created."
  type        = string
  default     = null
}

# variable "mgmt_eni_primary_ip" {
#   description = "Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
#   type        = string
# }

# variable "wan_eni_primary_ip" {
#   description = "Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
#   type        = string
# }

# variable "lan_eni_primary_ip" {
#   description = "Choose an IP Address within the LAN Subnet for the Primary lan interface. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
#   type        = string
# }

# variable "mgmt_eni_secondary_ip" {
#   description = "Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
#   type        = string
# }

# variable "lan_eni_secondary_ip" {
#   description = "Choose an IP Address within the LAN Subnet for the Secondary lan interface. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
#   type        = string
# }

variable "subnet_range_mgmt_primary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}
variable "subnet_range_mgmt_secondary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}
variable "subnet_range_wan_primary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}
variable "subnet_range_wan_secondary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
}

# variable "subnet_range_lan_primary" {
#   type        = string
#   description = <<EOT
#     Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.
#     The minimum subnet length to support High Availability is /29.
#     The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
# 	EOT
# }

# variable "subnet_range_lan_secondary" {
#   type        = string
#   description = <<EOT
#     Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.
#     The minimum subnet length to support High Availability is /29.
#     The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
# 	EOT
# }
