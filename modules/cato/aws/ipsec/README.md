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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_cato"></a> [cato](#provider\_cato) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.cgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_vpn_connection.vpn_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_gateway.vgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [cato_ipsec_site.ipsec-site](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/ipsec_site) | resource |
| [cato_license.license](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/license) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_asn"></a> [bgp\_asn](#input\_bgp\_asn) | BGP ASN for the customer gateway | `number` | n/a | yes |
| <a name="input_cgw_ip"></a> [cgw\_ip](#input\_cgw\_ip) | Public IP address for the customer gateway | `string` | n/a | yes |
| <a name="input_downstream_bw"></a> [downstream\_bw](#input\_downstream\_bw) | Downstream bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_license_bw"></a> [license\_bw](#input\_license\_bw) | The license bandwidth number for the cato site, specifying bandwidth ONLY applies for pooled licenses.  For a standard site license that is not pooled, leave this value null. Must be a number greater than 0 and an increment of 10. | `string` | `null` | no |
| <a name="input_license_id"></a> [license\_id](#input\_license\_id) | The license ID for the Cato vSocket of license type CATO\_SITE, CATO\_SSE\_SITE, CATO\_PB, CATO\_PB\_SSE.  Example License ID value: 'abcde123-abcd-1234-abcd-abcde1234567'.  Note that licenses are for commercial accounts, and not supported for trial accounts. | `string` | `null` | no |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | Native network range for the IPSec site | `string` | n/a | yes |
| <a name="input_primary_destination_type"></a> [primary\_destination\_type](#input\_primary\_destination\_type) | The destination type of the IPsec tunnel | `string` | `null` | no |
| <a name="input_primary_pop_location_id"></a> [primary\_pop\_location\_id](#input\_primary\_pop\_location\_id) | Primary tunnel POP location ID | `string` | `null` | no |
| <a name="input_primary_private_cato_ip"></a> [primary\_private\_cato\_ip](#input\_primary\_private\_cato\_ip) | Private IP address of the Cato side for the primary tunnel | `string` | n/a | yes |
| <a name="input_primary_private_site_ip"></a> [primary\_private\_site\_ip](#input\_primary\_private\_site\_ip) | Private IP address of the site side for the primary tunnel | `string` | n/a | yes |
| <a name="input_primary_public_cato_ip_id"></a> [primary\_public\_cato\_ip\_id](#input\_primary\_public\_cato\_ip\_id) | Public IP address ID of the Cato side for the primary tunnel | `string` | n/a | yes |
| <a name="input_secondary_destination_type"></a> [secondary\_destination\_type](#input\_secondary\_destination\_type) | The destination type of the IPsec tunnel | `string` | `null` | no |
| <a name="input_secondary_pop_location_id"></a> [secondary\_pop\_location\_id](#input\_secondary\_pop\_location\_id) | Secondary tunnel POP location ID | `string` | `null` | no |
| <a name="input_secondary_private_cato_ip"></a> [secondary\_private\_cato\_ip](#input\_secondary\_private\_cato\_ip) | Private IP address of the Cato side for the secondary tunnel | `string` | n/a | yes |
| <a name="input_secondary_private_site_ip"></a> [secondary\_private\_site\_ip](#input\_secondary\_private\_site\_ip) | Private IP address of the site side for the secondary tunnel | `string` | n/a | yes |
| <a name="input_secondary_public_cato_ip_id"></a> [secondary\_public\_cato\_ip\_id](#input\_secondary\_public\_cato\_ip\_id) | Public IP address ID of the Cato side for the secondary tunnel | `string` | n/a | yes |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the IPSec site | `string` | n/a | yes |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | n/a | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": "Belmont",<br/>  "country_code": "US",<br/>  "state_code": "US-CA",<br/>  "timezone": "America/Los_Angeles"<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the IPSec site | `string` | n/a | yes |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_upstream_bw"></a> [upstream\_bw](#input\_upstream\_bw) | Upstream bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the VPN gateway will be attached | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cato_license_site"></a> [cato\_license\_site](#output\_cato\_license\_site) | n/a |
| <a name="output_site_id"></a> [site\_id](#output\_site\_id) | ID of the created Cato IPSec site |
| <a name="output_tunnel1_address"></a> [tunnel1\_address](#output\_tunnel1\_address) | n/a |
| <a name="output_tunnel1_preshared_key"></a> [tunnel1\_preshared\_key](#output\_tunnel1\_preshared\_key) | n/a |
| <a name="output_tunnel2_address"></a> [tunnel2\_address](#output\_tunnel2\_address) | n/a |
| <a name="output_tunnel2_preshared_key"></a> [tunnel2\_preshared\_key](#output\_tunnel2\_preshared\_key) | n/a |
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | ID of the created AWS VPN connection |
<!-- END_TF_DOCS -->