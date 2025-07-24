<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kali_server"></a> [kali\_server](#module\_kali\_server) | terraform-aws-modules/ec2-instance/aws | 5.8.0 |
| <a name="module_prod_test_servers"></a> [prod\_test\_servers](#module\_prod\_test\_servers) | terraform-aws-modules/ec2-instance/aws | 5.8.0 |
| <a name="module_test-env-vpc-1"></a> [test-env-vpc-1](#module\_test-env-vpc-1) | terraform-aws-modules/vpc/aws | 5.21.0 |
| <a name="module_test-env-vpc-2"></a> [test-env-vpc-2](#module\_test-env-vpc-2) | terraform-aws-modules/vpc/aws | 5.21.0 |
| <a name="module_test-env-vpc-3"></a> [test-env-vpc-3](#module\_test-env-vpc-3) | terraform-aws-modules/vpc/aws | 5.21.0 |
| <a name="module_vpc1_internal_security_group"></a> [vpc1\_internal\_security\_group](#module\_vpc1\_internal\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc2_internal_security_group"></a> [vpc2\_internal\_security\_group](#module\_vpc2\_internal\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc3_external_security_group"></a> [vpc3\_external\_security\_group](#module\_vpc3\_external\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc3_internal_security_group"></a> [vpc3\_internal\_security\_group](#module\_vpc3\_internal\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_windows_test_servers"></a> [windows\_test\_servers](#module\_windows\_test\_servers) | terraform-aws-modules/ec2-instance/aws | 5.8.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment.test-env-vpc-1-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.test-env-vpc-2-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.test-env-vpc-3-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route.vpc1_private_to_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc2_private_to_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc3_private_to_tgw-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc3_private_to_tgw-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc3_private_to_tgw-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc3_public_to_tgw-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc3_public_to_tgw-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc3_public_to_tgw-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_ami.amazon_linux_23](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.kali_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_kali"></a> [enable\_kali](#input\_enable\_kali) | Enable build of Kali Instances | `bool` | `false` | no |
| <a name="input_external_testing_range"></a> [external\_testing\_range](#input\_external\_testing\_range) | IP Address for Remote Access to Externally Faced Servers | `any` | `null` | no |
| <a name="input_keypair_name"></a> [keypair\_name](#input\_keypair\_name) | KeyPair for use on all Machines | `any` | n/a | yes |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | CIDR block for native subnet inside the vSocket | `string` | n/a | yes |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Name of the vsocket site | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A Map of Key Values which describe the infrastructure | `any` | n/a | yes |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | The ID of the transit gateway to use | `string` | n/a | yes |
| <a name="input_vpc1_cidr_block"></a> [vpc1\_cidr\_block](#input\_vpc1\_cidr\_block) | The CIDR Block for VPC1 Test VPC | `any` | `null` | no |
| <a name="input_vpc1_enable_dns_support"></a> [vpc1\_enable\_dns\_support](#input\_vpc1\_enable\_dns\_support) | Whether to enable DNS Support in Test VPC 1 | `bool` | `true` | no |
| <a name="input_vpc1_enable_nat_gateway"></a> [vpc1\_enable\_nat\_gateway](#input\_vpc1\_enable\_nat\_gateway) | Whether to Enable the NAT Gateway in Test VPC 1 | `bool` | `false` | no |
| <a name="input_vpc2_cidr_block"></a> [vpc2\_cidr\_block](#input\_vpc2\_cidr\_block) | The CIDR Block for VPC2 Test VPC | `any` | `null` | no |
| <a name="input_vpc2_enable_dns_support"></a> [vpc2\_enable\_dns\_support](#input\_vpc2\_enable\_dns\_support) | Whether to enable DNS Support in Test VPC 2 | `bool` | `true` | no |
| <a name="input_vpc2_enable_nat_gateway"></a> [vpc2\_enable\_nat\_gateway](#input\_vpc2\_enable\_nat\_gateway) | Whether to Enable the NAT Gateway in Test VPC 2 | `bool` | `false` | no |
| <a name="input_vpc3_cidr_block"></a> [vpc3\_cidr\_block](#input\_vpc3\_cidr\_block) | The CIDR Block for VPC3 Test VPC | `any` | `null` | no |
| <a name="input_vpc3_enable_dns_support"></a> [vpc3\_enable\_dns\_support](#input\_vpc3\_enable\_dns\_support) | Whether to enable DNS Support in Test VPC 3 | `bool` | `true` | no |
| <a name="input_vpc3_enable_nat_gateway"></a> [vpc3\_enable\_nat\_gateway](#input\_vpc3\_enable\_nat\_gateway) | Whether to Enable the NAT Gateway in Test VPC 3 | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | AMI ID used for EC2 instances |
| <a name="output_ec2_instance_ids"></a> [ec2\_instance\_ids](#output\_ec2\_instance\_ids) | EC2 instance IDs of deployed servers |
| <a name="output_ec2_instance_private_ips"></a> [ec2\_instance\_private\_ips](#output\_ec2\_instance\_private\_ips) | Private IPs of the deployed EC2 instances |
| <a name="output_ec2_instance_public_ips"></a> [ec2\_instance\_public\_ips](#output\_ec2\_instance\_public\_ips) | Public IPs of the EC2 instances that have public IPs |
| <a name="output_vpc1_cidr_block"></a> [vpc1\_cidr\_block](#output\_vpc1\_cidr\_block) | CIDR Block for VPC 1 |
| <a name="output_vpc1_id"></a> [vpc1\_id](#output\_vpc1\_id) | VPC ID for VPC 1 |
| <a name="output_vpc1_private_subnets"></a> [vpc1\_private\_subnets](#output\_vpc1\_private\_subnets) | Private subnets for VPC 1 |
| <a name="output_vpc1_tgw_attachment_id"></a> [vpc1\_tgw\_attachment\_id](#output\_vpc1\_tgw\_attachment\_id) | Transit Gateway Attachment ID for VPC 1 |
| <a name="output_vpc2_cidr_block"></a> [vpc2\_cidr\_block](#output\_vpc2\_cidr\_block) | CIDR Block for VPC 2 |
| <a name="output_vpc2_id"></a> [vpc2\_id](#output\_vpc2\_id) | VPC ID for VPC 2 |
| <a name="output_vpc2_private_subnets"></a> [vpc2\_private\_subnets](#output\_vpc2\_private\_subnets) | Private subnets for VPC 2 |
| <a name="output_vpc2_tgw_attachment_id"></a> [vpc2\_tgw\_attachment\_id](#output\_vpc2\_tgw\_attachment\_id) | Transit Gateway Attachment ID for VPC 2 |
| <a name="output_vpc3_cidr_block"></a> [vpc3\_cidr\_block](#output\_vpc3\_cidr\_block) | CIDR Block for VPC 3 |
| <a name="output_vpc3_id"></a> [vpc3\_id](#output\_vpc3\_id) | VPC ID for VPC 3 |
| <a name="output_vpc3_private_subnets"></a> [vpc3\_private\_subnets](#output\_vpc3\_private\_subnets) | Private subnets for VPC 3 |
| <a name="output_vpc3_public_ips"></a> [vpc3\_public\_ips](#output\_vpc3\_public\_ips) | Public IPs of servers in VPC 3 |
| <a name="output_vpc3_public_subnets"></a> [vpc3\_public\_subnets](#output\_vpc3\_public\_subnets) | Public subnets for VPC 3 |
<!-- END_TF_DOCS -->