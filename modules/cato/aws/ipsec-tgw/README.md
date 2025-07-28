<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.98.0 |
| <a name="requirement_cato"></a> [cato](#requirement\_cato) | >= 0.0.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ipsec-aws-tgw"></a> [ipsec-aws-tgw](#module\_ipsec-aws-tgw) | catonetworks/ipsec-aws-transit-gateway/cato | n/a |
| <a name="module_test_env"></a> [test\_env](#module\_test\_env) | ../../../aws/test-env-tgw | n/a |
| <a name="module_transit-gateway"></a> [transit-gateway](#module\_transit-gateway) | terraform-aws-modules/transit-gateway/aws | ~> 2.13.0 |

## Resources

| Name | Type |
|------|------|
| [random_password.primary_vpn_tunnel1_preshared_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.secondary_vpn_tunnel1_preshared_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cato Networks Account ID | `string` | n/a | yes |
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Amazon side ASN for the Transit Gateway | `number` | `null` | no |
| <a name="input_build_aws_ipsec_tgw_test_env"></a> [build\_aws\_ipsec\_tgw\_test\_env](#input\_build\_aws\_ipsec\_tgw\_test\_env) | Build Test Environment for TGW | `bool` | `false` | no |
| <a name="input_cato_bgp_asn"></a> [cato\_bgp\_asn](#input\_cato\_bgp\_asn) | Cato BGP ASN - Defaults to 64515 | `number` | `64515` | no |
| <a name="input_cato_primary_gateway_ip_address"></a> [cato\_primary\_gateway\_ip\_address](#input\_cato\_primary\_gateway\_ip\_address) | Cato Primary Gateway IP Address from Available Allocated IPs | `any` | n/a | yes |
| <a name="input_cato_secondary_gateway_ip_address"></a> [cato\_secondary\_gateway\_ip\_address](#input\_cato\_secondary\_gateway\_ip\_address) | Cato Secondary Gateway IP Address from Available Allocated IPs | `any` | n/a | yes |
| <a name="input_downstream_bw"></a> [downstream\_bw](#input\_downstream\_bw) | Downstream bandwidth in Mbps | `number` | `100` | no |
| <a name="input_enable_auto_accept_shared_attachments"></a> [enable\_auto\_accept\_shared\_attachments](#input\_enable\_auto\_accept\_shared\_attachments) | Auto accept shared attachments | `bool` | `null` | no |
| <a name="input_enable_default_route_table_association"></a> [enable\_default\_route\_table\_association](#input\_enable\_default\_route\_table\_association) | Enable association with default TGW route table | `bool` | `null` | no |
| <a name="input_enable_default_route_table_propagation"></a> [enable\_default\_route\_table\_propagation](#input\_enable\_default\_route\_table\_propagation) | Enable propagation with default TGW route table | `bool` | `null` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support | `bool` | `null` | no |
| <a name="input_enable_kali"></a> [enable\_kali](#input\_enable\_kali) | Enable Kali Instances in Test\_Env | `bool` | `false` | no |
| <a name="input_enable_multicast_support"></a> [enable\_multicast\_support](#input\_enable\_multicast\_support) | Enable multicast support | `bool` | `null` | no |
| <a name="input_enable_sg_referencing_support"></a> [enable\_sg\_referencing\_support](#input\_enable\_sg\_referencing\_support) | Enable Security Group referencing support | `bool` | `null` | no |
| <a name="input_enable_vpn_ecmp_support"></a> [enable\_vpn\_ecmp\_support](#input\_enable\_vpn\_ecmp\_support) | Enable ECMP for VPN | `bool` | `null` | no |
| <a name="input_external_testing_range"></a> [external\_testing\_range](#input\_external\_testing\_range) | IP Address for Remote Access to Externally Faced Servers | `any` | `null` | no |
| <a name="input_kali_ami_id"></a> [kali\_ami\_id](#input\_kali\_ami\_id) | Custom AMI ID for Kali | `any` | `null` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Name of the EC2 Key Pair to use for SSH access | `string` | n/a | yes |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | CIDR block for native subnet inside the vSocket | `string` | `"10.7.0.0/16"` | no |
| <a name="input_primary_private_cato_ip"></a> [primary\_private\_cato\_ip](#input\_primary\_private\_cato\_ip) | Private IP address of the Cato side for the primary tunnel | `string` | `"169.254.101.2"` | no |
| <a name="input_primary_private_site_ip"></a> [primary\_private\_site\_ip](#input\_primary\_private\_site\_ip) | Private IP address of the site side for the primary tunnel | `string` | `"169.254.101.1"` | no |
| <a name="input_primary_vpn_tunnel1_inside_cidr"></a> [primary\_vpn\_tunnel1\_inside\_cidr](#input\_primary\_vpn\_tunnel1\_inside\_cidr) | Primary VPN, Tunnel 1 Inside CIDR | `string` | `"169.254.100.0/30"` | no |
| <a name="input_primary_vpn_tunnel2_inside_cidr"></a> [primary\_vpn\_tunnel2\_inside\_cidr](#input\_primary\_vpn\_tunnel2\_inside\_cidr) | Primary VPN, Tunnel 1 Inside CIDR | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_secondary_private_cato_ip"></a> [secondary\_private\_cato\_ip](#input\_secondary\_private\_cato\_ip) | Private IP address of the Cato side for the secondary tunnel | `string` | `"169.254.201.2"` | no |
| <a name="input_secondary_private_site_ip"></a> [secondary\_private\_site\_ip](#input\_secondary\_private\_site\_ip) | Private IP address of the site side for the secondary tunnel | `string` | `"169.254.201.1"` | no |
| <a name="input_secondary_vpn_tunnel1_inside_cidr"></a> [secondary\_vpn\_tunnel1\_inside\_cidr](#input\_secondary\_vpn\_tunnel1\_inside\_cidr) | Primary VPN, Tunnel 2 Inside CIDR | `string` | `"169.254.200.0/30"` | no |
| <a name="input_secondary_vpn_tunnel2_inside_cidr"></a> [secondary\_vpn\_tunnel2\_inside\_cidr](#input\_secondary\_vpn\_tunnel2\_inside\_cidr) | Primary VPN, Tunnel 2 Inside CIDR | `string` | `null` | no |
| <a name="input_share_tgw"></a> [share\_tgw](#input\_share\_tgw) | Share TGW with other accounts | `bool` | `null` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Description of the Cato site | `string` | `"AWS Cato IPSEC TGW Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name for the Cato site | `string` | `"AWS-Cato-IPSEC-TGW-Site"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | <pre>{<br/>  "built_with": "terraform",<br/>  "cato_site_type": "AWS-Cato-vSocket-IPSEC-Site",<br/>  "git_repo": "https://github.com/catonetworks/terraform-example-usage"<br/>}</pre> | no |
| <a name="input_token"></a> [token](#input\_token) | Cato Networks API Token | `string` | n/a | yes |
| <a name="input_transit_gateway_cidr_blocks"></a> [transit\_gateway\_cidr\_blocks](#input\_transit\_gateway\_cidr\_blocks) | Optional CIDR blocks for the TGW | `list(string)` | `null` | no |
| <a name="input_upstream_bw"></a> [upstream\_bw](#input\_upstream\_bw) | Upstream bandwidth in Mbps | `number` | `100` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_test_env_private_ips"></a> [test\_env\_private\_ips](#output\_test\_env\_private\_ips) | Private IPs of Servers |
| <a name="output_vpc3_public_ips_from_test_env"></a> [vpc3\_public\_ips\_from\_test\_env](#output\_vpc3\_public\_ips\_from\_test\_env) | Public IPs of VPC 3 servers in the test\_env module |
<!-- END_TF_DOCS -->