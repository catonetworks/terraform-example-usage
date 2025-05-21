# Cato Variables
variable "baseurl" {
  description = "Cato Networks API URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "token" {
  description = "Cato Networks API Token"
  type        = string
  #sensitive   = true
}

variable "account_id" {
  description = "Cato Networks Account ID"
  type        = string
}

variable "vpc_range" {
  type        = string
  description = <<EOT
  	Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = "10.4.0.0/16"
}

variable "vpc_id" {
  description = "The VPC ID where the VPN gateway will be attached"
  type        = string
  default     = null
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway to be used for the VPC"
  type        = string
  default     = null
}

variable "site_name" {
  description = "Name of the vsocket site"
  type        = string
  default     = "AWS-Cato-vSocket-HA-VPC-Site"
}

variable "site_description" {
  description = "Description of the vsocket site"
  type        = string
  default     = "AWS Cato vSocket HA VPC Site"
}

variable "site_type" {
  description = "The type of the site"
  type        = string
  default     = "CLOUD_DC"
  validation {
    condition     = contains(["DATACENTER", "BRANCH", "CLOUD_DC", "HEADQUARTERS"], var.site_type)
    error_message = "The site_type variable must be one of 'DATACENTER','BRANCH','CLOUD_DC','HEADQUARTERS'."
  }
}

variable "site_location" {
  type = object({
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    city         = "San Diego"
    country_code = "US"
    state_code   = "US-CA" ## Optional - for countries with states
    timezone     = "America/Los_Angeles"
  }
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

variable "lan_ingress_cidr_blocks" {
  type        = list(any)
  description = <<EOT
  	Set CIDR to receive traffic from the specified IPv4 CIDR address ranges
	For example x.x.x.x/32 to allow one specific IP address access, 0.0.0.0/0 to allow all IP addresses access, or another CIDR range
    Best practice is to allow a few IPs as possible
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT  
  default     = ["0.0.0.0/0"]
}


variable "instance_type" {
  description = "The instance type of the vSocket"
  type        = string
  default     = "c5.xlarge"
  validation {
    condition     = contains(["d2.xlarge", "c3.xlarge", "t3.large", "t3.xlarge", "c4.xlarge", "c5.xlarge", "c5d.xlarge", "c5n.xlarge"], var.instance_type)
    error_message = "The instance_type variable must be one of 'd2.xlarge','c3.xlarge','t3.large','t3.xlarge','c4.xlarge','c5.xlarge','c5d.xlarge','c5n.xlarge'."
  }
}

variable "key_pair" {
  description = "Name of an existing Key Pair for AWS encryption"
  type        = string
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
  default     = null
}

variable "mgmt_eni_secondary_ip" {
  description = "Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X"
  type        = string
  default     = null
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

variable "subnet_range_mgmt_primary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_wan_primary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_mgmt_secondary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.
    The minimum subnet length to support High Availability is /28.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_wan_secondary" {
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
    Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.
    The minimum subnet length to support High Availability is /29.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "subnet_range_lan_secondary" {
  type        = string
  description = <<EOT
    Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.
    The minimum subnet length to support High Availability is /29.
    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
	EOT
  default     = null
}

variable "tags" {
  description = "Tags to be appended to AWS resources"
  type        = map(string)
  default     = {}
}

variable "native_network_range" {
  type        = string
  description = <<EOT
  The Native network range for the Cato Site.  This is not necessarily just the VPC Range, but anything behind the Cato Devices within AWS. 
  The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X
  EOT
  default     = "10.4.0.0/16"
}