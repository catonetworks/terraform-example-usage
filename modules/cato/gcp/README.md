# Cato Networks GCP vSocket Terraform Module

The Cato vSocket modules deploys a vSocket instance to connect to the Cato Cloud.

# Pre-reqs
- Install the [Google Cloud Platform CLI](https://cloud.google.com/sdk/docs/install)
`$ /google-cloud-sdk/install.sh`
- Run the following to configure the GCP CLI
`$ gcloud auth application-default login`

# GCP Network and Resource Dependencies

<details>
<summary>Create new GCP VPC and network resources</summary>

The following exmaple shows how to create the required resources as new.

```hcl
# VPC Networks
resource "google_compute_network" "vpc_mgmt" {
  name                    = var.vpc_mgmt_name
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_wan" {
  name                    = var.vpc_wan_name
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_lan" {
  name                    = var.vpc_lan_name
  auto_create_subnetworks = false
}

# Subnets
resource "google_compute_subnetwork" "subnet_mgmt" {
  name          = var.subnet_mgmt_name
  ip_cidr_range = var.subnet_mgmt_cidr
  network       = google_compute_network.vpc_mgmt.id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_wan" {
  name          = var.subnet_wan_name
  ip_cidr_range = var.subnet_wan_cidr
  network       = google_compute_network.vpc_wan.id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_lan" {
  name          = var.subnet_lan_name
  ip_cidr_range = var.subnet_lan_cidr
  network       = google_compute_network.vpc_lan.id
  region        = var.region
}

# Static IPs
resource "google_compute_address" "ip_mgmt" {
  count        = var.public_ip_mgmt ? 1 : 0
  name         = var.ip_mgmt_name
  region       = var.region
  network_tier = var.network_tier
}

resource "google_compute_address" "ip_wan" {
  count        = var.public_ip_wan ? 1 : 0
  name         = var.ip_wan_name
  region       = var.region
  network_tier = var.network_tier
}

resource "google_compute_address" "ip_lan" {
  name         = var.ip_lan_name
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.subnet_lan.id
}
```

</details>

<details>
<summary>Use existing GCP VPC and network resources (data sources)</summary>

The following exmaple shows how to use existing resources in GCP retrieving the necessary values using GCP data sources.

```hcl
# VPC Networks
data "google_compute_network" "vpc_mgmt" {
  name                    = var.vpc_mgmt_name
}

data "google_compute_network" "vpc_wan" {
  name                    = var.vpc_wan_name
}

data "google_compute_network" "vpc_lan" {
  name                    = var.vpc_lan_name
}

# Subnets
data "google_compute_subnetwork" "subnet_mgmt" {
  name          = var.subnet_mgmt_name
  region        = var.region
}

data "google_compute_subnetwork" "subnet_wan" {
  name          = var.subnet_wan_name
  region        = var.region
}

data "google_compute_subnetwork" "subnet_lan" {
  name          = var.subnet_lan_name
  region        = var.region
}

# Static IPs
data "google_compute_address" "ip_mgmt" {
  name         = var.ip_mgmt_name
}

data "google_compute_address" "ip_wan" {
  name         = var.ip_wan_name
}

data "google_compute_address" "ip_lan" {
  name         = var.ip_lan_name
}
```

</details>

## NOTE
- For help with finding exact sytax to match site location for city, state_name, country_name and timezone, please refer to the [cato_siteLocation data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/siteLocation).
- For help with finding a license id to assign, please refer to the [cato_licensingInfo data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/licensingInfo).

## Usage

```hcl
provider "google" {
  project = var.project
  region  = var.region
}

provider "cato" {
  baseurl    = var.baseurl
  token      = var.token
  account_id = var.account_id
}

# GCP/Cato vsocket Module
module "vsocket-gpc" {
  source                   = "catonetworks/vsocket-gcp/cato"
  token                    = var.cato_token
  account_id               = var.account_id
  allowed_ports            = ["22", "443"]
  create_firewall_rule     = true
  firewall_rule_name       = "allow-management-access" # Only used if create_firewall_rule = true
  lan_compute_network_id   = google_compute_network.vpc_lan.id
  native_network_range     = "10.2.0.0/24"
  lan_network_ip           = "10.2.0.10" 
  lan_subnet_id            = google_compute_subnetwork.subnet_lan.id
  management_source_ranges = ["11.22.33.44/32"] # Only used if create_firewall_rule = true
  mgmt_compute_network_id  = google_compute_network.vpc_mgmt.id
  mgmt_network_ip          = "10.0.0.10"
  mgmt_static_ip_address   = google_compute_address.ip_mgmt[0].address
  mgmt_subnet_id           = google_compute_subnetwork.subnet_mgmt.id
  project                  = "cato-vsocket-deployment"
  region                   = "us-west1"
  site_name                = "Cato-GCP-us-west1"
  site_description         = "GCP Site us-west1"
  site_location            = {
    city         = "Los Angeles"
    country_code = "US"
    state_code   = "US-CA" ## Optional - for countries with states
    timezone     = "America/Los_Angeles"
  }
  vm_name                  = "gcp-vsocket-instance"
  wan_compute_network_id   = google_compute_network.vpc_wan.id
  wan_network_ip           = "10.1.0.10"
  wan_static_ip_address    = google_compute_address.ip_wan[0].address
  wan_subnet_id            = google_compute_subnetwork.subnet_wan.id
  zone                     = "us-west1-a"
  tags                     = ["customtag1","tcustomtag1est2"]
  labels                   = {
    customLabel = "mylabel"
    customLabel = "mylabel2"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cato"></a> [cato](#provider\_cato) | n/a |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cato_license.license](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/license) | resource |
| [cato_socket_site.gcp-site](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/socket_site) | resource |
| [google_compute_disk.boot_disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |
| [google_compute_firewall.allow_rfc1918](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_ssh_https](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.vsocket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [null_resource.destroy_delay](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [cato_accountSnapshotSite.gcp-site](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/accountSnapshotSite) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ports"></a> [allowed\_ports](#input\_allowed\_ports) | List of ports to allow through the firewall (Required) | `list(string)` | n/a | yes |
| <a name="input_boot_disk_image"></a> [boot\_disk\_image](#input\_boot\_disk\_image) | Boot disk image | `string` | `"projects/cato-vsocket-production/global/images/gcp-socket-image-v22-0-19207"` | no |
| <a name="input_boot_disk_size"></a> [boot\_disk\_size](#input\_boot\_disk\_size) | Boot disk size in GB (minimum 10 GB) | `number` | `10` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Model of Cato vsocket | `string` | `"SOCKET_GCP1500"` | no |
| <a name="input_create_firewall_rule"></a> [create\_firewall\_rule](#input\_create\_firewall\_rule) | Whether to create the firewall rule for management access | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be appended to GCP resources | `map(string)` | `{}` | no |
| <a name="input_lan_compute_network_id"></a> [lan\_compute\_network\_id](#input\_lan\_compute\_network\_id) | ID of existing LAN Compute Network | `string` | n/a | yes |
| <a name="input_lan_firewall_rule_name"></a> [lan\_firewall\_rule\_name](#input\_lan\_firewall\_rule\_name) | Name of the internal firewall rule (1-63 chars, lowercase letters, numbers, or hyphens) | `string` | `"allow-rfc1918-to-cato-lan"` | no |
| <a name="input_lan_network_ip"></a> [lan\_network\_ip](#input\_lan\_network\_ip) | LAN network IP | `string` | n/a | yes |
| <a name="input_lan_subnet_id"></a> [lan\_subnet\_id](#input\_lan\_subnet\_id) | ID of existing LAN Subnet | `string` | n/a | yes |
| <a name="input_license_bw"></a> [license\_bw](#input\_license\_bw) | The license bandwidth number for the cato site, specifying bandwidth ONLY applies for pooled licenses.  For a standard site license that is not pooled, leave this value null. Must be a number greater than 0 and an increment of 10. | `string` | `null` | no |
| <a name="input_license_id"></a> [license\_id](#input\_license\_id) | The license ID for the Cato vSocket of license type CATO\_SITE, CATO\_SSE\_SITE, CATO\_PB, CATO\_PB\_SSE.  Example License ID value: 'abcde123-abcd-1234-abcd-abcde1234567'.  Note that licenses are for commercial accounts, and not supported for trial accounts. | `string` | `null` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type | `string` | `"n2-standard-4"` | no |
| <a name="input_management_source_ranges"></a> [management\_source\_ranges](#input\_management\_source\_ranges) | Source IP ranges that can access the instance via SSH/HTTPS (Required) | `list(string)` | n/a | yes |
| <a name="input_mgmt_compute_network_id"></a> [mgmt\_compute\_network\_id](#input\_mgmt\_compute\_network\_id) | ID of existing Management Compute Network | `string` | n/a | yes |
| <a name="input_mgmt_network_ip"></a> [mgmt\_network\_ip](#input\_mgmt\_network\_ip) | Management network IP | `string` | n/a | yes |
| <a name="input_mgmt_static_ip_address"></a> [mgmt\_static\_ip\_address](#input\_mgmt\_static\_ip\_address) | Name of existing Management Static IP | `string` | n/a | yes |
| <a name="input_mgmt_subnet_id"></a> [mgmt\_subnet\_id](#input\_mgmt\_subnet\_id) | ID of existing Management Subnet | `string` | n/a | yes |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | Choose the unique network range your vpc is configured with for your socket that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |
| <a name="input_network_tier"></a> [network\_tier](#input\_network\_tier) | Network tier for the public IP | `string` | `"STANDARD"` | no |
| <a name="input_public_ip_mgmt"></a> [public\_ip\_mgmt](#input\_public\_ip\_mgmt) | Whether to assign the existing static IP to management interface. If false, no public IP will be assigned. | `bool` | `true` | no |
| <a name="input_public_ip_wan"></a> [public\_ip\_wan](#input\_public\_ip\_wan) | Whether to assign the existing static IP to WAN interface. If false, no public IP will be assigned. | `bool` | `true` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the vsocket site | `string` | n/a | yes |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | n/a | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | n/a | yes |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the vsocket site | `string` | n/a | yes |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be appended to GCP resources | `list(string)` | `[]` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | VM Instance name (must be 1-63 characters, lowercase letters, numbers, or hyphens) | `string` | n/a | yes |
| <a name="input_wan_compute_network_id"></a> [wan\_compute\_network\_id](#input\_wan\_compute\_network\_id) | ID of existing WAN Compute Network | `string` | n/a | yes |
| <a name="input_wan_firewall_rule_name"></a> [wan\_firewall\_rule\_name](#input\_wan\_firewall\_rule\_name) | Name of the external firewall rule (1-63 chars, lowercase letters, numbers, or hyphens) | `string` | n/a | yes |
| <a name="input_wan_network_ip"></a> [wan\_network\_ip](#input\_wan\_network\_ip) | WAN network IP | `string` | n/a | yes |
| <a name="input_wan_static_ip_address"></a> [wan\_static\_ip\_address](#input\_wan\_static\_ip\_address) | Name of existing WAN Static IP | `string` | n/a | yes |
| <a name="input_wan_subnet_id"></a> [wan\_subnet\_id](#input\_wan\_subnet\_id) | ID of existing WAN Subnet | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP Zone | `string` | `"me-west1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_boot_disk_name"></a> [boot\_disk\_name](#output\_boot\_disk\_name) | Boot disk name for the VM |
| <a name="output_boot_disk_self_link"></a> [boot\_disk\_self\_link](#output\_boot\_disk\_self\_link) | Self-link for the boot disk |
| <a name="output_cato_license_site"></a> [cato\_license\_site](#output\_cato\_license\_site) | n/a |
| <a name="output_cato_serial_id"></a> [cato\_serial\_id](#output\_cato\_serial\_id) | Serial ID of the Cato Site Socket |
| <a name="output_cato_site_id"></a> [cato\_site\_id](#output\_cato\_site\_id) | ID of the Cato Socket Site |
| <a name="output_cato_site_name"></a> [cato\_site\_name](#output\_cato\_site\_name) | Name of the Cato Site |
| <a name="output_firewall_rule_name"></a> [firewall\_rule\_name](#output\_firewall\_rule\_name) | Name of the created firewall rule |
| <a name="output_firewall_rule_rfc1918"></a> [firewall\_rule\_rfc1918](#output\_firewall\_rule\_rfc1918) | Firewall rule name for RFC1918 private IP ranges |
| <a name="output_firewall_rule_rfc1918_self_link"></a> [firewall\_rule\_rfc1918\_self\_link](#output\_firewall\_rule\_rfc1918\_self\_link) | Self-link of the RFC1918 firewall rule |
| <a name="output_vm_instance_name"></a> [vm\_instance\_name](#output\_vm\_instance\_name) | Name of the VM instance |
| <a name="output_vm_instance_self_link"></a> [vm\_instance\_self\_link](#output\_vm\_instance\_self\_link) | Self-link for the VM instance |
| <a name="output_vm_labels"></a> [vm\_labels](#output\_vm\_labels) | Labels assigned to the VM |
| <a name="output_vm_lan_network_ip"></a> [vm\_lan\_network\_ip](#output\_vm\_lan\_network\_ip) | LAN network private IP of the VM |
| <a name="output_vm_mgmt_network_ip"></a> [vm\_mgmt\_network\_ip](#output\_vm\_mgmt\_network\_ip) | Management network private IP of the VM |
| <a name="output_vm_mgmt_public_ip"></a> [vm\_mgmt\_public\_ip](#output\_vm\_mgmt\_public\_ip) | Management public IP if assigned |
| <a name="output_vm_wan_network_ip"></a> [vm\_wan\_network\_ip](#output\_vm\_wan\_network\_ip) | WAN network private IP of the VM |
| <a name="output_vm_wan_public_ip"></a> [vm\_wan\_public\_ip](#output\_vm\_wan\_public\_ip) | WAN public IP if assigned |
<!-- END_TF_DOCS -->