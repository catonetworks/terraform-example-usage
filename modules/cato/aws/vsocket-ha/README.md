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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_cato"></a> [cato](#provider\_cato) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cato_ha_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cato_ha_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cato_ha_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cato_ha_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.primary_vsocket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.secondary_vsocket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [cato_license.license](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/license) | resource |
| [cato_socket_site.aws-site](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/socket_site) | resource |
| [null_resource.configure_secondary_aws_vsocket](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.sleep_300_seconds](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.sleep_300_seconds-HA](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.sleep_30_seconds](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.vsocket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [cato_accountSnapshotSite.aws-site-2](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/accountSnapshotSite) | data source |
| [cato_accountSnapshotSite.aws-site-primary](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/accountSnapshotSite) | data source |
| [cato_accountSnapshotSite.aws-site-secondary](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/accountSnapshotSite) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cato account ID | `number` | n/a | yes |
| <a name="input_baseurl"></a> [baseurl](#input\_baseurl) | Cato API base URL | `string` | `"https://api.catonetworks.com/api/v1/graphql2"` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Model of Cato vsocket | `string` | `"SOCKET_AWS1500"` | no |
| <a name="input_ebs_disk_size"></a> [ebs\_disk\_size](#input\_ebs\_disk\_size) | Size of disk | `number` | `32` | no |
| <a name="input_ebs_disk_type"></a> [ebs\_disk\_type](#input\_ebs\_disk\_type) | Size of disk | `string` | `"gp2"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type of the vSocket | `string` | `"c5.xlarge"` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Name of an existing Key Pair for AWS encryption | `string` | n/a | yes |
| <a name="input_lan_eni_primary_id"></a> [lan\_eni\_primary\_id](#input\_lan\_eni\_primary\_id) | LAN Elastic Network Interface ID, network interface connected to a private subnet for local VPC resources to connect to for access to internet and WAN access through the Cato socket. Example: eni-abcde12345abcde12345 | `string` | n/a | yes |
| <a name="input_lan_eni_secondary_id"></a> [lan\_eni\_secondary\_id](#input\_lan\_eni\_secondary\_id) | LAN Elastic Network Interface ID, network interface connected to a private subnet for local VPC resources to connect to for access to internet and WAN access through the Cato socket. Example: eni-abcde12345abcde12345 | `string` | n/a | yes |
| <a name="input_lan_local_primary_ip"></a> [lan\_local\_primary\_ip](#input\_lan\_local\_primary\_ip) | Choose an IP Address within the LAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface used as the default route for private resources to gain access to WAN and internet. The accepted input format is X.X.X.X | `string` | n/a | yes |
| <a name="input_lan_local_secondary_ip"></a> [lan\_local\_secondary\_ip](#input\_lan\_local\_secondary\_ip) | Choose an IP Address within the Secodnary LAN Subnet. You CANNOT use the first four assignable IP addresses within the subnet as it's reserved for the AWS virtual router interface used as the default route for private resources to gain access to WAN and internet. The accepted input format is X.X.X.X | `string` | n/a | yes |
| <a name="input_lan_route_table_id"></a> [lan\_route\_table\_id](#input\_lan\_route\_table\_id) | LAN route table id | `string` | n/a | yes |
| <a name="input_lan_subnet_primary_id"></a> [lan\_subnet\_primary\_id](#input\_lan\_subnet\_primary\_id) | Lan Subnet ID | `string` | n/a | yes |
| <a name="input_lan_subnet_secondary_id"></a> [lan\_subnet\_secondary\_id](#input\_lan\_subnet\_secondary\_id) | lan secondary Subnet ID | `string` | n/a | yes |
| <a name="input_license_bw"></a> [license\_bw](#input\_license\_bw) | The license bandwidth number for the cato site, specifying bandwidth ONLY applies for pooled licenses.  For a standard site license that is not pooled, leave this value null. Must be a number greater than 0 and an increment of 10. | `string` | `null` | no |
| <a name="input_license_id"></a> [license\_id](#input\_license\_id) | The license ID for the Cato vSocket of license type CATO\_SITE, CATO\_SSE\_SITE, CATO\_PB, CATO\_PB\_SSE.  Example License ID value: 'abcde123-abcd-1234-abcd-abcde1234567'.  Note that licenses are for commercial accounts, and not supported for trial accounts. | `string` | `null` | no |
| <a name="input_mgmt_eni_primary_id"></a> [mgmt\_eni\_primary\_id](#input\_mgmt\_eni\_primary\_id) | Managent Elastic Network Interface ID, network interface connected public to a subnet with routable access to the internet to access the internet and the Cato SASE cloud platform. Example: eni-abcde12345abcde12345 | `string` | n/a | yes |
| <a name="input_mgmt_eni_secondary_id"></a> [mgmt\_eni\_secondary\_id](#input\_mgmt\_eni\_secondary\_id) | Managent Elastic Network Interface ID, network interface connected public to a subnet with routable access to the internet to access the internet and the Cato SASE cloud platform. Example: eni-abcde12345abcde12345 | `string` | n/a | yes |
| <a name="input_mgmt_subnet_id"></a> [mgmt\_subnet\_id](#input\_mgmt\_subnet\_id) | Mgmt Subnet ID | `string` | n/a | yes |
| <a name="input_native_network_range_primary"></a> [native\_network\_range\_primary](#input\_native\_network\_range\_primary) | Choose the unique network range your vpc is configured with for your socket that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |
| <a name="input_native_network_range_secondary"></a> [native\_network\_range\_secondary](#input\_native\_network\_range\_secondary) | Choose the unique network range your vpc is configured with for your socket that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Site description | `string` | n/a | yes |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | The location of the site, used for timezone and geolocation.  Use the Cato CLI to get the list of locations. []() | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | n/a | yes |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Your Cato Site Name Here | `string` | n/a | yes |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be appended to AWS resources | `map(string)` | `{}` | no |
| <a name="input_token"></a> [token](#input\_token) | Cato API token | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
| <a name="input_wan_eni_primary_id"></a> [wan\_eni\_primary\_id](#input\_wan\_eni\_primary\_id) | WAN Elastic Network Interface ID, network interface connected to a public subnet with routable access to the internet to access the internet and the Cato SASE cloud platform. Example: eni-abcde12345abcde12345 | `string` | n/a | yes |
| <a name="input_wan_eni_secondary_id"></a> [wan\_eni\_secondary\_id](#input\_wan\_eni\_secondary\_id) | WAN Elastic Network Interface ID, network interface connected to a public subnet with routable access to the internet to access the internet and the Cato SASE cloud platform. Example: eni-abcde12345abcde12345 | `string` | n/a | yes |
| <a name="input_wan_subnet_id"></a> [wan\_subnet\_id](#input\_wan\_subnet\_id) | Wan Subnet ID | `string` | n/a | yes |

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
| <a name="output_secondary_socket_site_serial"></a> [secondary\_socket\_site\_serial](#output\_secondary\_socket\_site\_serial) | n/a |
| <a name="output_socket_site_id"></a> [socket\_site\_id](#output\_socket\_site\_id) | The following attributes are exported: |
| <a name="output_socket_site_serial"></a> [socket\_site\_serial](#output\_socket\_site\_serial) | n/a |
<!-- END_TF_DOCS -->