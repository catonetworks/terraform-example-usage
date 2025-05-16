locals {
  clean_site_name = regex("^[a-z][-a-z0-9]{0,61}[a-z0-9]?$", replace(lower(var.site_name), "_", "-"))
}

# VPC Networks
resource "google_compute_network" "vpc_mgmt" {
  name                    = "${local.clean_site_name}-mgmt-network"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_wan" {
  name                    = "${local.clean_site_name}-wan-network"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_lan" {
  name                    = "${local.clean_site_name}-lan-network"
  auto_create_subnetworks = false
}

# Subnets
resource "google_compute_subnetwork" "subnet_mgmt" {
  name          = "${local.clean_site_name}-mgmt-subnet"
  ip_cidr_range = var.subnet_mgmt_cidr
  network       = google_compute_network.vpc_mgmt.id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_wan" {
  name          = "${local.clean_site_name}-wan-subnet"
  ip_cidr_range = var.subnet_wan_cidr
  network       = google_compute_network.vpc_wan.id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_lan" {
  name          = "${local.clean_site_name}-lan-subnet"
  ip_cidr_range = var.subnet_lan_cidr
  network       = google_compute_network.vpc_lan.id
  region        = var.region
}

# Static IPs
resource "google_compute_address" "ip_mgmt" {
  count        = var.public_ip_mgmt ? 1 : 0
  name         = "${local.clean_site_name}-mgmt-int"
  region       = var.region
  network_tier = var.network_tier
}

resource "google_compute_address" "ip_wan" {
  count        = var.public_ip_wan ? 1 : 0
  name         = "${local.clean_site_name}-wan-int"
  region       = var.region
  network_tier = var.network_tier
}

resource "google_compute_address" "ip_lan" {
  name         = "${local.clean_site_name}-lan-int"
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.subnet_lan.id
}