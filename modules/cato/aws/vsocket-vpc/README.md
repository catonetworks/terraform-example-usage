# Cato Networks AWS vSocket Terraform Module

The Cato vSocket modules creates a VPC and deploys a vSocket instnace to connect the VPC to the Cato Cloud.

This module deploys the following resources
- 1 VPC
- 1 vSocket aws instance with 3 network interfaces (lan/wan/mgmt)
- 2 Elastic IPs (wan/mgmt)
- 1 internet gateway
- 3 routing tables with default routes (lan/wan/mgmt)
- 2 security groups (external/internal)
- 3 subnets (lan/wan/mgmt)


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
| <a name="module_vsocket-aws-vpc"></a> [vsocket-aws-vpc](#module\_vsocket-aws-vpc) | catonetworks/vsocket-aws-vpc/cato | n/a |

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
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the vsocket site | `string` | `"AWS Cato vSocket VPC Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the vsocket site | `string` | `"AWS-Cato-vSocket-VPC-Site"` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_subnet_range_lan"></a> [subnet\_range\_lan](#input\_subnet\_range\_lan) | Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /29.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_mgmt"></a> [subnet\_range\_mgmt](#input\_subnet\_range\_mgmt) | Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_wan"></a> [subnet\_range\_wan](#input\_subnet\_range\_wan) | Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_vpc_range"></a> [vpc\_range](#input\_vpc\_range) | Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `"10.2.0.0/16"` | no |
| <a name="input_wan_eni_ip"></a> [wan\_eni\_ip](#input\_wan\_eni\_ip) | Choose an IP Address within the Public/WAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface. The accepted input format is X.X.X.X | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cato_license_site"></a> [cato\_license\_site](#output\_cato\_license\_site) | n/a |
| <a name="output_cato_site_name"></a> [cato\_site\_name](#output\_cato\_site\_name) | n/a |
| <a name="output_external_sg"></a> [external\_sg](#output\_external\_sg) | n/a |
| <a name="output_internal_sg"></a> [internal\_sg](#output\_internal\_sg) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | module.vsocket-aws-vpc outputs |
| <a name="output_lan_eni_id"></a> [lan\_eni\_id](#output\_lan\_eni\_id) | n/a |
| <a name="output_lan_subnet_id"></a> [lan\_subnet\_id](#output\_lan\_subnet\_id) | n/a |
| <a name="output_lan_subnet_route_table_id"></a> [lan\_subnet\_route\_table\_id](#output\_lan\_subnet\_route\_table\_id) | n/a |
| <a name="output_local_ip"></a> [local\_ip](#output\_local\_ip) | n/a |
| <a name="output_mgmt_eip_id"></a> [mgmt\_eip\_id](#output\_mgmt\_eip\_id) | n/a |
| <a name="output_mgmt_eni_id"></a> [mgmt\_eni\_id](#output\_mgmt\_eni\_id) | n/a |
| <a name="output_mgmt_subnet_id"></a> [mgmt\_subnet\_id](#output\_mgmt\_subnet\_id) | n/a |
| <a name="output_native_network_range"></a> [native\_network\_range](#output\_native\_network\_range) | n/a |
| <a name="output_sg_external"></a> [sg\_external](#output\_sg\_external) | n/a |
| <a name="output_sg_internal"></a> [sg\_internal](#output\_sg\_internal) | n/a |
| <a name="output_socket_site_id"></a> [socket\_site\_id](#output\_socket\_site\_id) | n/a |
| <a name="output_socket_site_serial"></a> [socket\_site\_serial](#output\_socket\_site\_serial) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vsocket_instance_ami"></a> [vsocket\_instance\_ami](#output\_vsocket\_instance\_ami) | n/a |
| <a name="output_vsocket_instance_id"></a> [vsocket\_instance\_id](#output\_vsocket\_instance\_id) | n/a |
| <a name="output_vsocket_instance_public_ip"></a> [vsocket\_instance\_public\_ip](#output\_vsocket\_instance\_public\_ip) | n/a |
| <a name="output_wan_eip_id"></a> [wan\_eip\_id](#output\_wan\_eip\_id) | n/a |
| <a name="output_wan_eni_id"></a> [wan\_eni\_id](#output\_wan\_eni\_id) | n/a |
| <a name="output_wan_subnet_id"></a> [wan\_subnet\_id](#output\_wan\_subnet\_id) | n/a |
<!-- END_TF_DOCS -->