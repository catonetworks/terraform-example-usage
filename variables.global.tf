# Azure Provider Variables
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

# AWS Provider Variables
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_default_keypair" {
  description = "AWS Key Pair"
  type        = string
}

#GCP Provider Variables
variable "project" {
  description = "GCP Project ID for the deployment"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region for the deployment"
  type        = string
}

variable "zone" {
  description = "GCP Zone for the deployment"
  type        = string
}

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
  description = "Cato Networks Account ID"
  type        = string
}

# Settings for all AWS modules
variable "build_aws_ipsec_module" {
  description = "Build AWS IPsec site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_module" {
  description = "Build AWS vSocket site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_vpc_module" {
  description = "Build AWS vSocket VPC site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_ha_module" {
  description = "Build AWS vSocket VPC site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_ha_vpc_module" {
  description = "Build AWS vSocket VPC site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_tgw_module" {
  description = "Build AWS vSocket tgw site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_tgw_test_env" {
  description = "Build AWS vSocket tgw test env module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_tgw_ha_module" {
  description = "Build AWS vSocket tgw ha site module"
  type        = bool
  default     = false
}

variable "build_aws_vsocket_tgw_ha_test_env" {
  description = "Build AWS vSocket tgw ha test env module"
  type        = bool
  default     = false
}

variable "build_aws_ipsec_tgw_module" {
  description = "Build AWS IPsec tgw site module"
  type        = bool
  default     = false
}

variable "build_aws_ipsec_tgw_test_env" {
  description = "Build AWS IPsec tgw test env module"
  type        = bool
  default     = false
}

# Settings for all Azure modules
variable "build_azure_ipsec_module" {
  description = "Build Azure IPsec site module"
  type        = bool
  default     = false
}

variable "build_azure_vsocket_module" {
  description = "Build Azure vSocket site module"
  type        = bool
  default     = false
}

variable "build_azure_vsocket_vnet_module" {
  description = "Build Azure vSocket VNET site module"
  type        = bool
  default     = false
}

variable "build_azure_vsocket_ha_module" {
  description = "Build Azure vSocket VPC site module"
  type        = bool
  default     = false
}

variable "build_azure_vsocket_ha_vnet_module" {
  description = "Build Azure vSocket VNET site module"
  type        = bool
  default     = false
}

variable "build_azure_vwan_module" {
  description = "Build Azure vWAN Site Module"
  type        = bool
  default     = false
}

variable "build_azure_vsocket_ha_vnet_2nic_module" {
  description = "Build Azure vSocket Net 2NIC site Module"
  type        = bool
  default     = false
}

# Settings for all GCP modules
variable "build_gcp_ipsec_module" {
  description = "Build GCP IPsec site module"
  type        = bool
  default     = false
}

variable "build_gcp_vsocket_module" {
  description = "Build GCP vSocket site module"
  type        = bool
  default     = false
}

variable "build_gcp_vsocket_vpc_module" {
  description = "Build GCP vSocket VPC site module"
  type        = bool
  default     = false
}

# Settings for all GCP modules
variable "build_socket_csv_module" {
  description = "Build Socket site from csv module"
  type        = bool
  default     = false
}

variable "build_bulk_socket_csv_module" {
  description = "Build Bulk Socket site from csv module"
  type        = bool
  default     = false
}
