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
| <a name="module_test_env_ha"></a> [test\_env\_ha](#module\_test\_env\_ha) | ../../../aws/test-env-tgw | n/a |
| <a name="module_transit-gateway"></a> [transit-gateway](#module\_transit-gateway) | terraform-aws-modules/transit-gateway/aws | ~> 2.13.0 |
| <a name="module_vsocket-aws-tgw-ha"></a> [vsocket-aws-tgw-ha](#module\_vsocket-aws-tgw-ha) | catonetworks/vsocket-aws-tgw-ha/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cato account ID | `string` | n/a | yes |
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Amazon side ASN for the TGW | `number` | `null` | no |
| <a name="input_build_aws_vsocket_tgw_ha_test_env"></a> [build\_aws\_vsocket\_tgw\_ha\_test\_env](#input\_build\_aws\_vsocket\_tgw\_ha\_test\_env) | Build AWS vSocket tgw ha test env module | `bool` | n/a | yes |
| <a name="input_enable_auto_accept_shared_attachments"></a> [enable\_auto\_accept\_shared\_attachments](#input\_enable\_auto\_accept\_shared\_attachments) | Enable auto-accept shared attachments | `bool` | `null` | no |
| <a name="input_enable_default_route_table_association"></a> [enable\_default\_route\_table\_association](#input\_enable\_default\_route\_table\_association) | Enable default route table association | `bool` | `null` | no |
| <a name="input_enable_default_route_table_propagation"></a> [enable\_default\_route\_table\_propagation](#input\_enable\_default\_route\_table\_propagation) | Enable default route table propagation | `bool` | `null` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support on TGW | `bool` | `null` | no |
| <a name="input_enable_kali"></a> [enable\_kali](#input\_enable\_kali) | Enable Kali Instances in Test\_Env | `bool` | `false` | no |
| <a name="input_enable_multicast_support"></a> [enable\_multicast\_support](#input\_enable\_multicast\_support) | Enable multicast support on TGW | `bool` | `null` | no |
| <a name="input_enable_sg_referencing_support"></a> [enable\_sg\_referencing\_support](#input\_enable\_sg\_referencing\_support) | Enable TGW support for referencing security groups | `bool` | `null` | no |
| <a name="input_enable_vpn_ecmp_support"></a> [enable\_vpn\_ecmp\_support](#input\_enable\_vpn\_ecmp\_support) | Enable VPN Equal Cost Multi-Path support | `bool` | `null` | no |
| <a name="input_external_testing_range"></a> [external\_testing\_range](#input\_external\_testing\_range) | IP Address for Remote Access to Externally Faced Servers | `any` | `null` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of CIDR blocks allowed for ingress | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_kali_ami_id"></a> [kali\_ami\_id](#input\_kali\_ami\_id) | Custom AMI ID for Kali | `any` | `null` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Name of the AWS EC2 key pair | `string` | n/a | yes |
| <a name="input_lan_eni_primary_ip"></a> [lan\_eni\_primary\_ip](#input\_lan\_eni\_primary\_ip) | Primary LAN ENI private IP | `string` | `null` | no |
| <a name="input_lan_eni_secondary_ip"></a> [lan\_eni\_secondary\_ip](#input\_lan\_eni\_secondary\_ip) | Secondary LAN ENI private IP | `string` | `null` | no |
| <a name="input_mgmt_eni_primary_ip"></a> [mgmt\_eni\_primary\_ip](#input\_mgmt\_eni\_primary\_ip) | Primary management ENI private IP | `string` | `null` | no |
| <a name="input_mgmt_eni_secondary_ip"></a> [mgmt\_eni\_secondary\_ip](#input\_mgmt\_eni\_secondary\_ip) | Secondary management ENI private IP | `string` | `null` | no |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | Native network CIDR range for Cato integration | `string` | `"10.6.0.0/16"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_share_tgw"></a> [share\_tgw](#input\_share\_tgw) | Indicates whether the TGW should be shared with other accounts | `bool` | `null` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the Cato site | `string` | `"AWS Cato vSocket TGW HA Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the Cato site | `string` | `"AWS-Cato-vSocket-TGW-HA-Site"` | no |
| <a name="input_subnet_range_lan_primary"></a> [subnet\_range\_lan\_primary](#input\_subnet\_range\_lan\_primary) | Primary LAN subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_lan_secondary"></a> [subnet\_range\_lan\_secondary](#input\_subnet\_range\_lan\_secondary) | Secondary LAN subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_mgmt_primary"></a> [subnet\_range\_mgmt\_primary](#input\_subnet\_range\_mgmt\_primary) | Primary management subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_mgmt_secondary"></a> [subnet\_range\_mgmt\_secondary](#input\_subnet\_range\_mgmt\_secondary) | Secondary management subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_tgw_primary"></a> [subnet\_range\_tgw\_primary](#input\_subnet\_range\_tgw\_primary) | Primary TGW subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_tgw_secondary"></a> [subnet\_range\_tgw\_secondary](#input\_subnet\_range\_tgw\_secondary) | Secondary TGW subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_wan_primary"></a> [subnet\_range\_wan\_primary](#input\_subnet\_range\_wan\_primary) | Primary WAN subnet CIDR | `string` | `null` | no |
| <a name="input_subnet_range_wan_secondary"></a> [subnet\_range\_wan\_secondary](#input\_subnet\_range\_wan\_secondary) | Secondary WAN subnet CIDR | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | <pre>{<br/>  "built_with": "terraform",<br/>  "cato_site_type": "AWS-Cato-vSocket-TGW-HA-Site",<br/>  "git_repo": "https://github.com/catonetworks/terraform-example-usage"<br/>}</pre> | no |
| <a name="input_token"></a> [token](#input\_token) | Cato API token for authentication | `string` | n/a | yes |
| <a name="input_transit_gateway_cidr_blocks"></a> [transit\_gateway\_cidr\_blocks](#input\_transit\_gateway\_cidr\_blocks) | CIDR blocks for the Transit Gateway | `list(string)` | `null` | no |
| <a name="input_vpc_network_range"></a> [vpc\_network\_range](#input\_vpc\_network\_range) | CIDR block for the VPC | `string` | `"10.6.0.0/24"` | no |
| <a name="input_wan_eni_primary_ip"></a> [wan\_eni\_primary\_ip](#input\_wan\_eni\_primary\_ip) | Primary WAN ENI private IP | `string` | `null` | no |
| <a name="input_wan_eni_secondary_ip"></a> [wan\_eni\_secondary\_ip](#input\_wan\_eni\_secondary\_ip) | Secondary WAN ENI private IP | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_test_env_private_ips"></a> [test\_env\_private\_ips](#output\_test\_env\_private\_ips) | Private IPs of Servers |
| <a name="output_vpc3_public_ips_from_test_env"></a> [vpc3\_public\_ips\_from\_test\_env](#output\_vpc3\_public\_ips\_from\_test\_env) | Public IPs of VPC 3 servers in the test\_env module |
<!-- END_TF_DOCS -->