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
| <a name="module_test_env"></a> [test\_env](#module\_test\_env) | ../../../aws/test-env-tgw | n/a |
| <a name="module_transit-gateway"></a> [transit-gateway](#module\_transit-gateway) | terraform-aws-modules/transit-gateway/aws | ~> 2.13.0 |
| <a name="module_vsocket-aws-vpc-tgw"></a> [vsocket-aws-vpc-tgw](#module\_vsocket-aws-vpc-tgw) | catonetworks/vsocket-aws-tgw/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Amazon side ASN for the Transit Gateway | `number` | `null` | no |
| <a name="input_build_aws_vsocket_tgw_test_env"></a> [build\_aws\_vsocket\_tgw\_test\_env](#input\_build\_aws\_vsocket\_tgw\_test\_env) | Build Test Environment for TGW | `bool` | `false` | no |
| <a name="input_enable_auto_accept_shared_attachments"></a> [enable\_auto\_accept\_shared\_attachments](#input\_enable\_auto\_accept\_shared\_attachments) | Auto accept shared attachments | `bool` | `null` | no |
| <a name="input_enable_default_route_table_association"></a> [enable\_default\_route\_table\_association](#input\_enable\_default\_route\_table\_association) | Enable association with default TGW route table | `bool` | `null` | no |
| <a name="input_enable_default_route_table_propagation"></a> [enable\_default\_route\_table\_propagation](#input\_enable\_default\_route\_table\_propagation) | Enable propagation with default TGW route table | `bool` | `null` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support | `bool` | `null` | no |
| <a name="input_enable_multicast_support"></a> [enable\_multicast\_support](#input\_enable\_multicast\_support) | Enable multicast support | `bool` | `null` | no |
| <a name="input_enable_sg_referencing_support"></a> [enable\_sg\_referencing\_support](#input\_enable\_sg\_referencing\_support) | Enable Security Group referencing support | `bool` | `null` | no |
| <a name="input_enable_vpn_ecmp_support"></a> [enable\_vpn\_ecmp\_support](#input\_enable\_vpn\_ecmp\_support) | Enable ECMP for VPN | `bool` | `null` | no |
| <a name="input_external_testing_range"></a> [external\_testing\_range](#input\_external\_testing\_range) | IP Address for Remote Access to Externally Faced Servers | `any` | `null` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of CIDR blocks allowed to access the vSocket | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Name of the EC2 Key Pair to use for SSH access | `string` | n/a | yes |
| <a name="input_lan_eni_ip"></a> [lan\_eni\_ip](#input\_lan\_eni\_ip) | Static IP for the LAN ENI | `string` | `null` | no |
| <a name="input_mgmt_eni_ip"></a> [mgmt\_eni\_ip](#input\_mgmt\_eni\_ip) | Static IP for the management ENI | `string` | `null` | no |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | CIDR block for native subnet inside the vSocket | `string` | `"10.5.0.0/16"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_share_tgw"></a> [share\_tgw](#input\_share\_tgw) | Share TGW with other accounts | `bool` | `null` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the Cato site | `string` | `"AWS Cato vSocket TGW Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name for the Cato site | `string` | `"AWS-Cato-vSocket-TGW-Site"` | no |
| <a name="input_subnet_range_lan"></a> [subnet\_range\_lan](#input\_subnet\_range\_lan) | CIDR block for the LAN subnet | `string` | `null` | no |
| <a name="input_subnet_range_mgmt"></a> [subnet\_range\_mgmt](#input\_subnet\_range\_mgmt) | CIDR block for the management subnet | `string` | `null` | no |
| <a name="input_subnet_range_tgw"></a> [subnet\_range\_tgw](#input\_subnet\_range\_tgw) | CIDR block for the TGW subnet | `string` | `null` | no |
| <a name="input_subnet_range_wan"></a> [subnet\_range\_wan](#input\_subnet\_range\_wan) | CIDR block for the WAN subnet | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | <pre>{<br/>  "built_with": "terraform",<br/>  "cato_site_type": "AWS-Cato-vSocket-TGW-Site",<br/>  "git_repo": "https://github.com/catonetworks/terraform-example-usage"<br/>}</pre> | no |
| <a name="input_transit_gateway_cidr_blocks"></a> [transit\_gateway\_cidr\_blocks](#input\_transit\_gateway\_cidr\_blocks) | Optional CIDR blocks for the TGW | `list(string)` | `null` | no |
| <a name="input_vpc_network_range"></a> [vpc\_network\_range](#input\_vpc\_network\_range) | CIDR block for the new VPC | `string` | `"10.5.0.0/24"` | no |
| <a name="input_wan_eni_ip"></a> [wan\_eni\_ip](#input\_wan\_eni\_ip) | Static IP for the WAN ENI | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc3_public_ips_from_test_env"></a> [vpc3\_public\_ips\_from\_test\_env](#output\_vpc3\_public\_ips\_from\_test\_env) | Public IPs of VPC 3 servers in the test\_env module |
<!-- END_TF_DOCS -->