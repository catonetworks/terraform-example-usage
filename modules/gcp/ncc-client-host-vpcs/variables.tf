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

variable "create_ilb_next_hop_routes" {
  description = "Whether to create custom static routes with next_hop_ilb. Keep false for NCC multi-VPC architecture, because Compute Route next_hop_ilb requires the ILB to be in the same VPC network."
  type        = bool
  default     = false
}

variable "inter_tier_route_priority" {
  description = "Priority for custom static inter-tier routes to Internal LB (web->app and app->web)."
  type        = number
  default     = 100
}

variable "inspection_default_route_priority" {
  description = "Priority for default route (0.0.0.0/0) to Internal LB for non-local traffic inspection."
  type        = number
  default     = 5
}

# ------------------------------------------------------------------------------
# Test VMs (web/app prod subnets)
# ------------------------------------------------------------------------------
variable "create_test_vms" {
  description = "Whether to create simple Ubuntu test VMs in web/app prod subnets."
  type        = bool
  default     = true
}

variable "web_test_vm_name" {
  description = "Name of the Ubuntu test VM in web-tier subnet-prod."
  type        = string
  default     = "web-prod-test-vm"
}

variable "app_test_vm_name" {
  description = "Name of the Ubuntu test VM in app-tier subnet-prod."
  type        = string
  default     = "app-prod-test-vm"
}

variable "web_test_vm_zone" {
  description = "Zone for web-tier test VM. If null, defaults to {region}-b."
  type        = string
  default     = null
}

variable "app_test_vm_zone" {
  description = "Zone for app-tier test VM. If null, defaults to {region}-c."
  type        = string
  default     = null
}

variable "test_vm_machine_type" {
  description = "Machine type for test VMs."
  type        = string
  default     = "e2-micro"
}

variable "test_vm_assign_public_ip" {
  description = "Assign ephemeral public IPs to test VMs for direct SSH access."
  type        = bool
  default     = true
}

variable "enable_test_vm_oslogin" {
  description = "Enable OS Login metadata on test VMs."
  type        = bool
  default     = true
}

variable "test_vm_ssh_source_ranges" {
  description = "Source ranges allowed to SSH (TCP/22) to test VMs."
  type        = list(string)
  #default     = ["35.235.240.0/20"]
  default     = ["0.0.0.0/0"]
}
