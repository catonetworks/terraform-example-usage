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
  count        = var.create_ilb_next_hop_routes && var.load_balancer_self_link != "" ? 1 : 0
  project      = var.web_tier_project_id
  name         = "route-to-app-tier-via-security-ilb"
  network      = google_compute_network.web_vpc.name
  dest_range   = "10.2.0.0/16"
  priority     = var.inter_tier_route_priority
  next_hop_ilb = var.load_balancer_self_link
}

# Route: internet (0.0.0.0/0) via Security VPC Internal LB (SASE)
resource "google_compute_route" "web_to_internet_via_ilb" {
  count        = var.create_ilb_next_hop_routes && var.load_balancer_self_link != "" ? 1 : 0
  project      = var.web_tier_project_id
  name         = "route-to-internet-via-security-ilb"
  network      = google_compute_network.web_vpc.name
  dest_range   = "0.0.0.0/0"
  priority     = var.inspection_default_route_priority
  next_hop_ilb = var.load_balancer_self_link
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
  count        = var.create_ilb_next_hop_routes && var.load_balancer_self_link != "" ? 1 : 0
  project      = var.app_tier_project_id
  name         = "route-to-web-tier-via-security-ilb"
  network      = google_compute_network.app_vpc.name
  dest_range   = "10.1.0.0/16"
  priority     = var.inter_tier_route_priority
  next_hop_ilb = var.load_balancer_self_link
}

# Route: internet (0.0.0.0/0) via Security VPC Internal LB (SASE)
resource "google_compute_route" "app_to_internet_via_ilb" {
  count        = var.create_ilb_next_hop_routes && var.load_balancer_self_link != "" ? 1 : 0
  project      = var.app_tier_project_id
  name         = "route-to-internet-via-security-ilb"
  network      = google_compute_network.app_vpc.name
  dest_range   = "0.0.0.0/0"
  priority     = var.inspection_default_route_priority
  next_hop_ilb = var.load_balancer_self_link
}

# ------------------------------------------------------------------------------
# Test VMs (Ubuntu) in subnet-prod
# ------------------------------------------------------------------------------
resource "google_compute_firewall" "web_allow_ssh" {
  count   = var.create_test_vms ? 1 : 0
  project = var.web_tier_project_id
  name    = "${var.web_vpc_name}-allow-ssh-test-vm"
  network = google_compute_network.web_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.test_vm_ssh_source_ranges
  target_tags   = ["test-vm"]
}

resource "google_compute_firewall" "app_allow_ssh" {
  count   = var.create_test_vms ? 1 : 0
  project = var.app_tier_project_id
  name    = "${var.app_vpc_name}-allow-ssh-test-vm"
  network = google_compute_network.app_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.test_vm_ssh_source_ranges
  target_tags   = ["test-vm"]
}

resource "google_compute_firewall" "web_allow_from_app" {
  count   = var.create_test_vms ? 1 : 0
  project = var.web_tier_project_id
  name    = "${var.web_vpc_name}-allow-from-app-tier-test"
  network = google_compute_network.web_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.2.0.0/16"]
  target_tags   = ["test-vm"]
}

resource "google_compute_firewall" "app_allow_from_web" {
  count   = var.create_test_vms ? 1 : 0
  project = var.app_tier_project_id
  name    = "${var.app_vpc_name}-allow-from-web-tier-test"
  network = google_compute_network.app_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.1.0.0/16"]
  target_tags   = ["test-vm"]
}

resource "google_compute_instance" "web_test_vm" {
  count        = var.create_test_vms ? 1 : 0
  project      = var.web_tier_project_id
  name         = var.web_test_vm_name
  machine_type = var.test_vm_machine_type
  zone         = coalesce(var.web_test_vm_zone, "${var.region}-b")
  tags         = ["test-vm"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.web_subnet_prod.id

    dynamic "access_config" {
      for_each = var.test_vm_assign_public_ip ? [1] : []
      content {}
    }
  }

  metadata = {
    enable-oslogin = tostring(var.enable_test_vm_oslogin)
  }

  metadata_startup_script = "echo web-test-vm > /etc/motd"
}

resource "google_compute_instance" "app_test_vm" {
  count        = var.create_test_vms ? 1 : 0
  project      = var.app_tier_project_id
  name         = var.app_test_vm_name
  machine_type = var.test_vm_machine_type
  zone         = coalesce(var.app_test_vm_zone, "${var.region}-c")
  tags         = ["test-vm"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.app_subnet_prod.id

    dynamic "access_config" {
      for_each = var.test_vm_assign_public_ip ? [1] : []
      content {}
    }
  }

  metadata = {
    enable-oslogin = tostring(var.enable_test_vm_oslogin)
  }

  metadata_startup_script = "echo app-test-vm > /etc/motd"
}
