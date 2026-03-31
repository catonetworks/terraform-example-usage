# ------------------------------------------------------------------------------
# Client part: Host Project web-tier and app-tier (from diagram)
# Create these in existing GCP projects. Terraform identity needs
# roles/compute.networkAdmin (or equivalent) in both projects.
# ------------------------------------------------------------------------------

variable "region" {
  description = "GCP region (must match security project region)."
  type        = string
}

# Web-tier (Host Project / web-tier)
variable "web_tier_project_id" {
  description = "GCP project ID for Host Project / web-tier."
  type        = string
}

variable "web_vpc_name" {
  description = "Name of the VPC in web-tier (diagram: web-vpc-1)."
  type        = string
  default     = "web-vpc-1"
}

variable "web_subnet_prod_cidr" {
  description = "Web-tier subnet-prod CIDR (diagram: 10.1.0.0/20)."
  type        = string
  default     = "10.1.0.0/20"
}

variable "web_subnet_dev_cidr" {
  description = "Web-tier subnet-dev CIDR (diagram: 10.1.16.0/20)."
  type        = string
  default     = "10.1.16.0/20"
}

variable "web_subnet_test_cidr" {
  description = "Web-tier subnet-test CIDR (diagram: 10.1.32.0/20)."
  type        = string
  default     = "10.1.32.0/20"
}

# App-tier (Host Project / app-tier)
variable "app_tier_project_id" {
  description = "GCP project ID for Host Project / app-tier."
  type        = string
}

variable "app_vpc_name" {
  description = "Name of the VPC in app-tier (diagram: app-vpc-1)."
  type        = string
  default     = "app-vpc-1"
}

variable "app_subnet_prod_cidr" {
  description = "App-tier subnet-prod CIDR (diagram: 10.2.0.0/20)."
  type        = string
  default     = "10.2.0.0/20"
}

variable "app_subnet_dev_cidr" {
  description = "App-tier subnet-dev CIDR (diagram: 10.2.16.0/20)."
  type        = string
  default     = "10.2.16.0/20"
}

variable "app_subnet_test_cidr" {
  description = "App-tier subnet-test CIDR (diagram: 10.2.32.0/20)."
  type        = string
  default     = "10.2.32.0/20"
}

# Routes: next-hop Internal LB in security project (from NCC example output)
# Leave empty to create only VPCs/subnets (run NCC example first to get LB, then re-apply with this set).
variable "load_balancer_self_link" {
  description = "Self-link of the Internal Load Balancer in the security project (from vsocket-ha-ncc example output). Used as next_hop_ilb for custom static routes. Set to empty string to create only VPCs and subnets (then run NCC example and re-apply with this value to create routes)."
  type        = string
  default     = ""
}

variable "custom_route_priority" {
  description = "Priority for custom static routes to Internal LB (diagram: 5)."
  type        = number
  default     = 5
}
