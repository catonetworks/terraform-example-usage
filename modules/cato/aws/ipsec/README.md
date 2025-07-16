# CATO IPSec AWS Terraform module

Terraform module which creates an IPsec site in the Cato Management Application (CMA), and a primary and secondary IPsec tunnel from AWS to the Cato platform.

## NOTE
- For help with finding exact sytax to match site location for city, state_name, country_name and timezone, please refer to the [cato_siteLocation data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/siteLocation).
- For help with finding a license id to assign, please refer to the [cato_licensingInfo data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/licensingInfo).

## Usage

```hcl
provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
}

module "ipsec-aws" {
  source = "catonetworks/ipsec-aws/cato"
  token = "xxxxxxx"
  account_id = "xxxxxxx"
  region                        = "us-east-1"
  bgp_asn                       = 65000
  vpc_id                        = "vpc-123abc"
  cgw_ip                        = "11.22.33.44"
  site_name                     = "AWS-Cato-IPSec-Site"
  site_description              = "AWS Cato IPSec Site US-East-2"
  native_network_range          = "10.1.0.0/16"
  primary_public_cato_ip_id     = "31511"
  primary_private_cato_ip       = "169.1.1.1"
  primary_private_site_ip       = "169.1.1.2"
  secondary_public_cato_ip_id   = "31512"
  secondary_private_cato_ip     = "169.2.1.1"
  secondary_private_site_ip     = "169.2.1.2"
  downstream_bw                 = 100
  upstream_bw                   = 100
  site_location = {
    city         = "New York City"
    country_code = "US"
    state_code   = "US-NY" ## Optional - for countries with states"
    timezone     = "America/New_York"
  }
}
```

## Site Location Reference

For more information on site_location syntax, use the [Cato CLI](https://github.com/catonetworks/cato-cli) to lookup values.

```bash
$ pip3 install catocli
$ export CATO_TOKEN="your-api-token-here"
$ export CATO_ACCOUNT_ID="your-account-id"
$ catocli query siteLocation -h
$ catocli query siteLocation '{"filters":[{"search": "San Diego","field":"city","operation":"exact"}]}' -p
```

## Authors

Module is maintained by [Cato Networks](https://github.com/catonetworks) with help from [these awesome contributors](https://github.com/catonetworks/terraform-cato-ipsec-aws/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/catonetworks/terraform-cato-ipsec-aws/tree/master/LICENSE) for full details.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.98.0 |
| <a name="requirement_cato"></a> [cato](#requirement\_cato) | >= 0.0.30 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ipsec-aws"></a> [ipsec-aws](#module\_ipsec-aws) | catonetworks/ipsec-aws/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_bgp_asn"></a> [aws\_bgp\_asn](#input\_aws\_bgp\_asn) | AWS's BGP Autonomous System Number | `number` | `65000` | no |
| <a name="input_cato_bgp_asn"></a> [cato\_bgp\_asn](#input\_cato\_bgp\_asn) | Cato's BGP Autonomous System Number | `number` | `65001` | no |
| <a name="input_downstream_bw"></a> [downstream\_bw](#input\_downstream\_bw) | Downstream bandwidth in Mbps for the IPSec tunnel in Cato (replace with the desired value) | `number` | `100` | no |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | Native network range for the IPSec site (replace with the desired network range) | `string` | `"10.0.0.0/16"` | no |
| <a name="input_primary_private_cato_ip"></a> [primary\_private\_cato\_ip](#input\_primary\_private\_cato\_ip) | Private IP address of the Cato side for the primary tunnel (replace with the desired value) | `string` | `"169.1.1.2"` | no |
| <a name="input_primary_private_site_ip"></a> [primary\_private\_site\_ip](#input\_primary\_private\_site\_ip) | Private IP address of the site side for the primary tunnel (replace with the desired value) | `string` | `"169.1.1.3"` | no |
| <a name="input_primary_public_cato_ip"></a> [primary\_public\_cato\_ip](#input\_primary\_public\_cato\_ip) | Public IP address ID of the Cato side for the primary tunnel (replace with the desired value) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be deployed. | `string` | n/a | yes |
| <a name="input_secondary_private_cato_ip"></a> [secondary\_private\_cato\_ip](#input\_secondary\_private\_cato\_ip) | Private IP address of the Cato side for the secondary tunnel (replace with the desired value) | `string` | `"169.2.1.2"` | no |
| <a name="input_secondary_private_site_ip"></a> [secondary\_private\_site\_ip](#input\_secondary\_private\_site\_ip) | Private IP address of the site side for the secondary tunnel (replace with the desired value) | `string` | `"169.2.1.3"` | no |
| <a name="input_secondary_public_cato_ip"></a> [secondary\_public\_cato\_ip](#input\_secondary\_public\_cato\_ip) | Public IP address ID of the Cato side for the secondary tunnel (replace with the desired value) | `string` | n/a | yes |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the IPSec site in Cato (replace with the desired description) | `string` | `"AWS Cato IPSec Site us-east-1"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the IPSec site in Cato (replace with the desired site name) | `string` | `"AWS-Cato-IPSec-Site"` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_upstream_bw"></a> [upstream\_bw](#input\_upstream\_bw) | Upstream bandwidth in Mbps for the IPSec tunnel in Cato (replace with the desired value) | `number` | `100` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the VPN gateway will be attached | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cato_license_site"></a> [cato\_license\_site](#output\_cato\_license\_site) | n/a |
| <a name="output_primary_tunnel_address"></a> [primary\_tunnel\_address](#output\_primary\_tunnel\_address) | n/a |
| <a name="output_primary_vpn_connection_id"></a> [primary\_vpn\_connection\_id](#output\_primary\_vpn\_connection\_id) | ID of the created AWS VPN connection |
| <a name="output_secondary_tunnel_address"></a> [secondary\_tunnel\_address](#output\_secondary\_tunnel\_address) | n/a |
| <a name="output_secondary_vpn_connection_id"></a> [secondary\_vpn\_connection\_id](#output\_secondary\_vpn\_connection\_id) | ID of the created AWS VPN connection |
| <a name="output_site_id"></a> [site\_id](#output\_site\_id) | ID of the created Cato IPSec site |
| <a name="output_tunnel1_preshared_key"></a> [tunnel1\_preshared\_key](#output\_tunnel1\_preshared\_key) | n/a |
| <a name="output_tunnel2_preshared_key"></a> [tunnel2\_preshared\_key](#output\_tunnel2\_preshared\_key) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the created Cato IPSec site |
<!-- END_TF_DOCS -->