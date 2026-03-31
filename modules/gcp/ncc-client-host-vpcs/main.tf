# ------------------------------------------------------------------------------
# CLIENT-CREATED: Host Project web-tier — Shared VPC web-vpc-1 + subnets + routes
# Diagram: Project - Host Project / web-tier, web-vpc-1, subnet-prod/dev/test
# Custom routes: 10.2.0.0/16 and 0.0.0.0/0 → Internal LB (Security VPC) for inspection
# ------------------------------------------------------------------------------

resource "google_compute_network" "web_vpc" {
  project                 = var.web_tier_project_id
  name                    = var.web_vpc_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "web_subnet_prod" {
  project       = var.web_tier_project_id
  name          = "subnet-prod"
  ip_cidr_range = var.web_subnet_prod_cidr
  network       = google_compute_network.web_vpc.id
  region        = var.region
}

resource "google_compute_subnetwork" "web_subnet_dev" {
  project       = var.web_tier_project_id
  name          = "subnet-dev"
  ip_cidr_range = var.web_subnet_dev_cidr
  network       = google_compute_network.web_vpc.id
  region        = var.region
}

resource "google_compute_subnetwork" "web_subnet_test" {
  project       = var.web_tier_project_id
  name          = "subnet-test"
  ip_cidr_range = var.web_subnet_test_cidr
  network       = google_compute_network.web_vpc.id
  region        = var.region
}

# Route: traffic to app-tier (10.2.0.0/16) via Security VPC Internal LB (created when load_balancer_self_link is set)
resource "google_compute_route" "web_to_app_via_ilb" {
  count            = var.load_balancer_self_link != "" ? 1 : 0
  project          = var.web_tier_project_id
  name             = "route-to-app-tier-via-security-ilb"
  network          = google_compute_network.web_vpc.name
  dest_range       = "10.2.0.0/16"
  priority         = var.custom_route_priority
  next_hop_ilb     = var.load_balancer_self_link
}

# Route: internet (0.0.0.0/0) via Security VPC Internal LB (SASE)
resource "google_compute_route" "web_to_internet_via_ilb" {
  count            = var.load_balancer_self_link != "" ? 1 : 0
  project          = var.web_tier_project_id
  name             = "route-to-internet-via-security-ilb"
  network          = google_compute_network.web_vpc.name
  dest_range       = "0.0.0.0/0"
  priority         = var.custom_route_priority
  next_hop_ilb     = var.load_balancer_self_link
}

# ------------------------------------------------------------------------------
# CLIENT-CREATED: Host Project app-tier — Shared VPC app-vpc-1 + subnets + routes
# Diagram: Project - Host Project / app-tier, app-vpc-1, subnet-prod/dev/test
# Custom routes: 10.1.0.0/16 and 0.0.0.0/0 → Internal LB (Security VPC)
# ------------------------------------------------------------------------------

resource "google_compute_network" "app_vpc" {
  project                 = var.app_tier_project_id
  name                    = var.app_vpc_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "app_subnet_prod" {
  project       = var.app_tier_project_id
  name          = "subnet-prod"
  ip_cidr_range = var.app_subnet_prod_cidr
  network       = google_compute_network.app_vpc.id
  region        = var.region
}

resource "google_compute_subnetwork" "app_subnet_dev" {
  project       = var.app_tier_project_id
  name          = "subnet-dev"
  ip_cidr_range = var.app_subnet_dev_cidr
  network       = google_compute_network.app_vpc.id
  region        = var.region
}

resource "google_compute_subnetwork" "app_subnet_test" {
  project       = var.app_tier_project_id
  name          = "subnet-test"
  ip_cidr_range = var.app_subnet_test_cidr
  network       = google_compute_network.app_vpc.id
  region        = var.region
}

# Route: traffic to web-tier (10.1.0.0/16) via Security VPC Internal LB (created when load_balancer_self_link is set)
resource "google_compute_route" "app_to_web_via_ilb" {
  count            = var.load_balancer_self_link != "" ? 1 : 0
  project          = var.app_tier_project_id
  name             = "route-to-web-tier-via-security-ilb"
  network          = google_compute_network.app_vpc.name
  dest_range       = "10.1.0.0/16"
  priority         = var.custom_route_priority
  next_hop_ilb     = var.load_balancer_self_link
}

# Route: internet (0.0.0.0/0) via Security VPC Internal LB (SASE)
resource "google_compute_route" "app_to_internet_via_ilb" {
  count            = var.load_balancer_self_link != "" ? 1 : 0
  project          = var.app_tier_project_id
  name             = "route-to-internet-via-security-ilb"
  network          = google_compute_network.app_vpc.name
  dest_range       = "0.0.0.0/0"
  priority         = var.custom_route_priority
  next_hop_ilb     = var.load_balancer_self_link
}
