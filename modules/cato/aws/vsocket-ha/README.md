# terraform-cato-vsocket-aws-ha

Terraform module which an Aws Socket HA Site in the Cato Management Application (CMA), and deploys a primary and secondary virtual socket EC2 instance in Aws and configures them as HA.

## NOTE
- For help with finding exact sytax to match site location for city, state_name, country_name and timezone, please refer to the [cato_siteLocation data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/siteLocation).
- For help with finding a license id to assign, please refer to the [cato_licensingInfo data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/licensingInfo).


## Usage

```hcl
provider "aws" {
  region = var.region
}

provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

module "vsocket-aws-ha" {
  source                         = "catonetworks/vsocket-aws-ha/cato"
  token                          = "xxxxxxx"
  account_id                     = "xxxxxxx"
  internet_gateway_id            = "igw-0a1b2c3d4e5f6g7h8"
  vpc_id                         = "vpc-xxxxxxxxxxxxxxxx"
  key_pair                       = "Your key pair"
  region                         = "eu-north-1"
  site_name                      = "Your-Cato-site-name-here"
  site_description               = "Your Cato site Description here"
  site_type                      = "CLOUD_DC"
  native_network_range_primary   = "10.2.3.0/24"
  native_network_range_secondary = "10.2.4.0/24"
  mgmt_subnet_id                 = "subnet-xxxxxxxxxxxxxxxx"
  wan_subnet_id                  = "subnet-xxxxxxxxxxxxxxxx"
  lan_local_primary_ip           = "10.2.3.5"
  lan_local_secondary_ip         = "10.2.4.5"
  lan_subnet_primary_id          = "subnet-xxxxxxxxxxxxxxxx"
  lan_subnet_secondary_id        = "subnet-xxxxxxxxxxxxxxxx"
  mgmt_eni_primary_id            = "eni-xxxxxxxxxxxxxxxx"
  wan_eni_primary_id             = "eni-xxxxxxxxxxxxxxxx"
  lan_eni_primary_id             = "eni-xxxxxxxxxxxxxxxx"
  mgmt_eni_secondary_id          = "eni-xxxxxxxxxxxxxxxx"
  wan_eni_secondary_id           = "eni-xxxxxxxxxxxxxxxx"
  lan_eni_secondary_id           = "eni-xxxxxxxxxxxxxxxx"
  lan_route_table_id             = "rtb-xxxxxxxxxxxxxxxx"
  site_location = {
    city         = "New York City"
    country_code = "US"
    state_code   = "US-NY" ## Optional - for countries with states"
    timezone     = "America/New_York"
  }
  tags                           = {
    TagName1  = "Tag Value 1"
    TagName2  = "Tag Value 2"
  }
}
```

## Imporant note for troubleshooting

In the event the module fails with the following error, this is an indication that the primary socket instance took longer than 5 minutes to upgrade and initialize.  

```
outputs.tf line X, in output "secondary_socket_site_serial":
│    X: output "secondary_socket_site_serial" { value = data.cato_accountSnapshotSite.aws-site-secondary.info.sockets[1].serial }
│     ├────────────────
│     │ data.cato_accountSnapshotSite.aws-site-secondary.info.sockets is list of object with 1 element
```

We need to rerun the process to add the secondary socket. To resolve this, simply taint the `null_resource.configure_secondary_aws_vsocket` resource and re-run terraform apply.  
Example:

```
terraform state list
terraform taint null_resource.configure_secondary_aws_vsocket
terraform apply
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

Module is maintained by [Cato Networks](https://github.com/catonetworks) with help from [these awesome contributors](https://github.com/catonetworks/terraform-cato-vsocket-aws-ha/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/catonetworks/terraform-cato-vsocket-aws-ha/tree/master/LICENSE) for full details.

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
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../aws/vpc-vsocket-ha | n/a |
| <a name="module_vsocket-aws-ha"></a> [vsocket-aws-ha](#module\_vsocket-aws-ha) | catonetworks/vsocket-aws-ha/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cato Networks Account ID | `string` | n/a | yes |
| <a name="input_baseurl"></a> [baseurl](#input\_baseurl) | Cato Networks API URL | `string` | `"https://api.catonetworks.com/api/v1/graphql2"` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | Set CIDR to receive traffic from the specified IPv4 CIDR address ranges<br/>	For example x.x.x.x/32 to allow one specific IP address access, 0.0.0.0/0 to allow all IP addresses access, or another CIDR range<br/>    Best practice is to allow a few IPs as possible<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `list(any)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type of the vSocket | `string` | `"c5.xlarge"` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Name of an existing Key Pair for AWS encryption | `string` | n/a | yes |
| <a name="input_lan_eni_primary_ip"></a> [lan\_eni\_primary\_ip](#input\_lan\_eni\_primary\_ip) | Choose an IP Address within the LAN Subnet for the Primary lan interface. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_lan_eni_secondary_ip"></a> [lan\_eni\_secondary\_ip](#input\_lan\_eni\_secondary\_ip) | Choose an IP Address within the LAN Subnet for the Secondary lan interface. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_mgmt_eni_primary_ip"></a> [mgmt\_eni\_primary\_ip](#input\_mgmt\_eni\_primary\_ip) | Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_mgmt_eni_secondary_ip"></a> [mgmt\_eni\_secondary\_ip](#input\_mgmt\_eni\_secondary\_ip) | Choose an IP Address within the Management Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the vsocket site | `string` | `"AWS Cato vSocket HA Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the vsocket site | `string` | `"AWS-Cato-vSocket-HA-Site"` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_subnet_range_lan_primary"></a> [subnet\_range\_lan\_primary](#input\_subnet\_range\_lan\_primary) | Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /29.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_lan_secondary"></a> [subnet\_range\_lan\_secondary](#input\_subnet\_range\_lan\_secondary) | Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /29.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_mgmt_primary"></a> [subnet\_range\_mgmt\_primary](#input\_subnet\_range\_mgmt\_primary) | Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_mgmt_secondary"></a> [subnet\_range\_mgmt\_secondary](#input\_subnet\_range\_mgmt\_secondary) | Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_wan_primary"></a> [subnet\_range\_wan\_primary](#input\_subnet\_range\_wan\_primary) | Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_wan_secondary"></a> [subnet\_range\_wan\_secondary](#input\_subnet\_range\_wan\_secondary) | Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be appended to AWS resources | `map(string)` | `{}` | no |
| <a name="input_token"></a> [token](#input\_token) | Cato Networks API Token | `string` | n/a | yes |
| <a name="input_vpc_range"></a> [vpc\_range](#input\_vpc\_range) | Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `"10.3.0.0/16"` | no |
| <a name="input_wan_eni_primary_ip"></a> [wan\_eni\_primary\_ip](#input\_wan\_eni\_primary\_ip) | Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |
| <a name="input_wan_eni_secondary_ip"></a> [wan\_eni\_secondary\_ip](#input\_wan\_eni\_secondary\_ip) | Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_availability_zones"></a> [aws\_availability\_zones](#output\_aws\_availability\_zones) | n/a |
| <a name="output_aws_iam_instance_profile_name"></a> [aws\_iam\_instance\_profile\_name](#output\_aws\_iam\_instance\_profile\_name) | n/a |
| <a name="output_aws_iam_policy_arn"></a> [aws\_iam\_policy\_arn](#output\_aws\_iam\_policy\_arn) | n/a |
| <a name="output_aws_iam_role_name"></a> [aws\_iam\_role\_name](#output\_aws\_iam\_role\_name) | n/a |
| <a name="output_aws_instance_primary_vsocket_id"></a> [aws\_instance\_primary\_vsocket\_id](#output\_aws\_instance\_primary\_vsocket\_id) | n/a |
| <a name="output_aws_instance_secondary_vsocket_id"></a> [aws\_instance\_secondary\_vsocket\_id](#output\_aws\_instance\_secondary\_vsocket\_id) | n/a |
| <a name="output_cato_license_site"></a> [cato\_license\_site](#output\_cato\_license\_site) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway associated with the VPC. |
| <a name="output_lan_eni_primary_id"></a> [lan\_eni\_primary\_id](#output\_lan\_eni\_primary\_id) | The ID of the primary LAN network interface. |
| <a name="output_lan_eni_secondary_id"></a> [lan\_eni\_secondary\_id](#output\_lan\_eni\_secondary\_id) | The ID of the secondary LAN network interface. |
| <a name="output_lan_route_table_id"></a> [lan\_route\_table\_id](#output\_lan\_route\_table\_id) | The ID of the LAN route table. |
| <a name="output_lan_subnet_primary_id"></a> [lan\_subnet\_primary\_id](#output\_lan\_subnet\_primary\_id) | The ID of the primary LAN subnet. |
| <a name="output_lan_subnet_secondary_id"></a> [lan\_subnet\_secondary\_id](#output\_lan\_subnet\_secondary\_id) | The ID of the secondary LAN subnet. |
| <a name="output_mgmt_eni_primary_id"></a> [mgmt\_eni\_primary\_id](#output\_mgmt\_eni\_primary\_id) | The ID of the primary management network interface. |
| <a name="output_mgmt_eni_secondary_id"></a> [mgmt\_eni\_secondary\_id](#output\_mgmt\_eni\_secondary\_id) | The ID of the secondary management network interface. |
| <a name="output_mgmt_route_table_id"></a> [mgmt\_route\_table\_id](#output\_mgmt\_route\_table\_id) | The ID of the management route table. |
| <a name="output_mgmt_subnet_primary_id"></a> [mgmt\_subnet\_primary\_id](#output\_mgmt\_subnet\_primary\_id) | The ID of the management subnet. |
| <a name="output_mgmteip_primary"></a> [mgmteip\_primary](#output\_mgmteip\_primary) | The public IP of the primary management Elastic IP. |
| <a name="output_mgmteip_secondary"></a> [mgmteip\_secondary](#output\_mgmteip\_secondary) | The public IP of the secondary management Elastic IP. |
| <a name="output_secondary_socket_site_serial"></a> [secondary\_socket\_site\_serial](#output\_secondary\_socket\_site\_serial) | n/a |
| <a name="output_sg_external"></a> [sg\_external](#output\_sg\_external) | The ID of the external security group. |
| <a name="output_sg_internal"></a> [sg\_internal](#output\_sg\_internal) | The ID of the internal security group. |
| <a name="output_socket_site_id"></a> [socket\_site\_id](#output\_socket\_site\_id) | module.vsocket-aws-ha outputs |
| <a name="output_socket_site_serial"></a> [socket\_site\_serial](#output\_socket\_site\_serial) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
| <a name="output_wan_eni_primary_id"></a> [wan\_eni\_primary\_id](#output\_wan\_eni\_primary\_id) | The ID of the primary WAN network interface. |
| <a name="output_wan_eni_secondary_id"></a> [wan\_eni\_secondary\_id](#output\_wan\_eni\_secondary\_id) | The ID of the secondary WAN network interface. |
| <a name="output_wan_route_table_id"></a> [wan\_route\_table\_id](#output\_wan\_route\_table\_id) | The ID of the WAN route table. |
| <a name="output_wan_subnet_primary_id"></a> [wan\_subnet\_primary\_id](#output\_wan\_subnet\_primary\_id) | The ID of the WAN subnet. |
| <a name="output_waneip_primary"></a> [waneip\_primary](#output\_waneip\_primary) | The public IP of the primary WAN Elastic IP. |
| <a name="output_waneip_secondary"></a> [waneip\_secondary](#output\_waneip\_secondary) | The public IP of the secondary WAN Elastic IP. |
<!-- END_TF_DOCS -->