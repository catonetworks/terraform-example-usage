# CATO VSOCKET AWS Terraform module

Terraform module which creates an AWS Socket Site in the Cato Management Application (CMA), and deploys a virtual socket ec2 instance in AWS.

## NOTE
- For help with finding exact sytax to match site location for city, state_name, country_name and timezone, please refer to the [cato_siteLocation data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/siteLocation).
- For help with finding a license id to assign, please refer to the [cato_licensingInfo data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/licensingInfo).

## Usage

```hcl
// Initialize Providers
provider "aws" {
  region = "us-east-1"
}

provider "cato" {
  baseurl    = var.baseurl
  token      = "xxxxxxxxxxxx"
  account_id = "xxxxxxxxxxxx"
}

// Virtual Socket Resource
module "vsocket-aws" {
  source = "catonetworks/vsocket-aws/cato"
  vpc_id               = "vpc-abcde12345abcde"
  key_pair             = "your-keypair-name-here"
  native_network_range = "10.1.0.0/16"
  mgmt_eni_id          = "eni-abcde12345abcde12mgmt"
  wan_eni_id           = "eni-abcde12345abcde123wan"
  lan_eni_id           = "eni-abcde12345abcde123lan"
  lan_local_ip         = "10.1.3.5"
  site_name            = "AWS Site us-east-2"
  site_description     = "AWS Site us-east-2"
  site_location = {
    city         = "New York City"
    country_code = "US"
    state_code   = "US-NY" ## Optional - for countries with states"
    timezone     = "America/New_York"
  }
  tags = {
    Environment = "Production"
    Owner = "Operations Team"
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

Module is maintained by [Cato Networks](https://github.com/catonetworks) with help from [these awesome contributors](https://github.com/catonetworks/terraform-cato-vsocket-aws/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/catonetworks/terraform-cato-vsocket-aws/tree/master/LICENSE) for full details.


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
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../aws/vpc-vsocket | n/a |
| <a name="module_vsocket-aws"></a> [vsocket-aws](#module\_vsocket-aws) | catonetworks/vsocket-aws/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | Set CIDR to receive traffic from the specified IPv4 CIDR address ranges<br/>	For example x.x.x.x/32 to allow one specific IP address access, 0.0.0.0/0 to allow all IP addresses access, or another CIDR range<br/>    Best practice is to allow a few IPs as possible<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `list(any)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type of the vSocket | `string` | `"c5.xlarge"` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Name of an existing Key Pair for AWS encryption | `string` | n/a | yes |
| <a name="input_lan_eni_ip"></a> [lan\_eni\_ip](#input\_lan\_eni\_ip) | Choose an IP Address within the LAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_mgmt_eni_ip"></a> [mgmt\_eni\_ip](#input\_mgmt\_eni\_ip) | Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the vsocket site | `string` | `"AWS Cato vSocket Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the vsocket site | `string` | `"AWS-Cato-vSocket-Site"` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_subnet_range_lan"></a> [subnet\_range\_lan](#input\_subnet\_range\_lan) | Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /29.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_mgmt"></a> [subnet\_range\_mgmt](#input\_subnet\_range\_mgmt) | Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_wan"></a> [subnet\_range\_wan](#input\_subnet\_range\_wan) | Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Specify a VPC ID to use. If not specified, a new VPC will be created. | `string` | `null` | no |
| <a name="input_vpc_range"></a> [vpc\_range](#input\_vpc\_range) | Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `"10.1.0.0/16"` | no |
| <a name="input_wan_eni_ip"></a> [wan\_eni\_ip](#input\_wan\_eni\_ip) | Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cato_site_name"></a> [cato\_site\_name](#output\_cato\_site\_name) | The Site Name of the Cato Networks Site (CMA) |
| <a name="output_ext_route"></a> [ext\_route](#output\_ext\_route) | n/a |
| <a name="output_external_route_table"></a> [external\_route\_table](#output\_external\_route\_table) | n/a |
| <a name="output_int_route"></a> [int\_route](#output\_int\_route) | n/a |
| <a name="output_internal_route_table"></a> [internal\_route\_table](#output\_internal\_route\_table) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | module.vpc outputs |
| <a name="output_lan_eni_id"></a> [lan\_eni\_id](#output\_lan\_eni\_id) | n/a |
| <a name="output_lan_network_interface"></a> [lan\_network\_interface](#output\_lan\_network\_interface) | n/a |
| <a name="output_lan_subnet_id"></a> [lan\_subnet\_id](#output\_lan\_subnet\_id) | n/a |
| <a name="output_lan_subnet_route_table_association"></a> [lan\_subnet\_route\_table\_association](#output\_lan\_subnet\_route\_table\_association) | n/a |
| <a name="output_local_ip"></a> [local\_ip](#output\_local\_ip) | The local IP of the Cato vSocket |
| <a name="output_mgmt_eip_association"></a> [mgmt\_eip\_association](#output\_mgmt\_eip\_association) | n/a |
| <a name="output_mgmt_elastic_ip"></a> [mgmt\_elastic\_ip](#output\_mgmt\_elastic\_ip) | n/a |
| <a name="output_mgmt_eni_id"></a> [mgmt\_eni\_id](#output\_mgmt\_eni\_id) | n/a |
| <a name="output_mgmt_network_interface"></a> [mgmt\_network\_interface](#output\_mgmt\_network\_interface) | n/a |
| <a name="output_mgmt_subnet_route_table_association"></a> [mgmt\_subnet\_route\_table\_association](#output\_mgmt\_subnet\_route\_table\_association) | n/a |
| <a name="output_native_network_range"></a> [native\_network\_range](#output\_native\_network\_range) | The Native Network Range of the Cato Networks Site (CMA) |
| <a name="output_sg_external"></a> [sg\_external](#output\_sg\_external) | n/a |
| <a name="output_sg_internal"></a> [sg\_internal](#output\_sg\_internal) | n/a |
| <a name="output_socket_site_id"></a> [socket\_site\_id](#output\_socket\_site\_id) | The Site ID of the Cato Networks Site (CMA) |
| <a name="output_socket_site_serial"></a> [socket\_site\_serial](#output\_socket\_site\_serial) | The Serial of the Cato Networks Socket |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vsocket_instance_ami"></a> [vsocket\_instance\_ami](#output\_vsocket\_instance\_ami) | The AMI used to build the vSocket |
| <a name="output_vsocket_instance_id"></a> [vsocket\_instance\_id](#output\_vsocket\_instance\_id) | The AWS Instance ID of the vSocket |
| <a name="output_vsocket_instance_public_ip"></a> [vsocket\_instance\_public\_ip](#output\_vsocket\_instance\_public\_ip) | The Public IP of the vSocket |
| <a name="output_wan_eip_association"></a> [wan\_eip\_association](#output\_wan\_eip\_association) | n/a |
| <a name="output_wan_elastic_ip"></a> [wan\_elastic\_ip](#output\_wan\_elastic\_ip) | n/a |
| <a name="output_wan_eni_id"></a> [wan\_eni\_id](#output\_wan\_eni\_id) | n/a |
| <a name="output_wan_network_interface"></a> [wan\_network\_interface](#output\_wan\_network\_interface) | n/a |
| <a name="output_wan_subnet_route_table_association"></a> [wan\_subnet\_route\_table\_association](#output\_wan\_subnet\_route\_table\_association) | n/a |
<!-- END_TF_DOCS -->