# CATO VSOCKET Azure VNET Terraform module

Terraform module which creates a VNET in Azure, required subnets, network interfaces, security groups, route tables, an Azure Socket Site in the Cato Management Application (CMA), and deploys a virtual socket VM instance in Azure.

For the azurerm_resource_group_name, leave null to create new or add a resource group namne to use existing.

## NOTE
- For help with finding exact sytax to match site location for city, state_name, country_name and timezone, please refer to the [cato_siteLocation data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/siteLocation).
- For help with finding a license id to assign, please refer to the [cato_licensingInfo data source](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/data-sources/licensingInfo).

<details>
<summary>Example Azure Resource Group</summary>

Create the Azure Resource Group resource using the following example syntax, and create this resources first before running the module:

```hcl
resource "azurerm_resource_group" "azure-rg" {
  location = var.az_location
  name     = "YourResourceGroupName"
}

terraform apply -target=azurerm_resource_group.azure-rg
```

Reference the resources as input variables with the following syntax:
```hcl
  resource_group_name  = azurerm_resource_group.azure-rg.name
```

</details>

## Usage

```hcl
provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {}
}

provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

module "vsocket-azure-vnet" {
  source              = "catonetworks/vsocket-azure-vnet/cato"
  vnet_prefix         = "10.3.0.0/16"
  subnet_range_mgmt   = "10.3.1.0/24"
  subnet_range_wan    = "10.3.2.0/24"
  subnet_range_lan    = "10.3.3.0/24"
  lan_ip              = "10.3.3.5"
  resource_group_name = null
  site_name           = "Your-Cato-site-name-here"
  site_description    = "Your Cato site desc here"
  site_location = {
    city         = "San Diego"
    country_code = "US"
    state_code   = "US-CA" ## Optional - for countries with states
    timezone     = "America/Los_Angeles"
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

Module is maintained by [Cato Networks](https://github.com/catonetworks) with help from [these awesome contributors](https://github.com/catonetworks/terraform-cato-vsocket-azure-vnet/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/catonetworks/terraform-cato-vsocket-azure-vnet/tree/master/LICENSE) for full details.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vsocket-azure"></a> [vsocket-azure](#module\_vsocket-azure) | catonetworks/vsocket-azure/cato | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.availability-set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_network_interface.lan-nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.mgmt-nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.wan-nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.lan-nic-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.mgmt-nic-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.wan-nic-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.lan-sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.mgmt-sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.wan-sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.mgmt-public-ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.wan-public-ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azure-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_route.lan-route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route.public-rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route.route-internet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.private-rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_route_table.public-rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.subnet-lan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet-mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet-wan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_route_table_association.rt-table-association-lan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.rt-table-association-mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.rt-table-association-wan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_dns_servers.dns_servers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_location"></a> [az\_location](#input\_az\_location) | (Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Disk size in GB | `number` | `8` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | n/a | `list(string)` | <pre>[<br/>  "10.254.254.1",<br/>  "168.63.129.16",<br/>  "1.1.1.1",<br/>  "8.8.8.8"<br/>]</pre> | no |
| <a name="input_image_reference_id"></a> [image\_reference\_id](#input\_image\_reference\_id) | Path to image used to deploy specific version of the virutal socket | `string` | `"/Subscriptions/38b5ec1d-b3b6-4f50-a34e-f04a67121955/Providers/Microsoft.Compute/Locations/eastus/Publishers/catonetworks/ArtifactTypes/VMImage/Offers/cato_socket/Skus/public-cato-socket/Versions/19.0.17805"` | no |
| <a name="input_lan_ip"></a> [lan\_ip](#input\_lan\_ip) | Local IP Address of socket LAN interface | `string` | `null` | no |
| <a name="input_license_bw"></a> [license\_bw](#input\_license\_bw) | The license bandwidth number for the cato site, specifying bandwidth ONLY applies for pooled licenses.  For a standard site license that is not pooled, leave this value null. Must be a number greater than 0 and an increment of 10. | `string` | `null` | no |
| <a name="input_license_id"></a> [license\_id](#input\_license\_id) | The license ID for the Cato vSocket of license type CATO\_SITE, CATO\_SSE\_SITE, CATO\_PB, CATO\_PB\_SSE.  Example License ID value: 'abcde123-abcd-1234-abcd-abcde1234567'.  Note that licenses are for commercial accounts, and not supported for trial accounts. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure resource group name | `string` | `null` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Site description | `string` | n/a | yes |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | n/a | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | n/a | yes |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Your Cato Site Name Here | `string` | `null` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"DATACENTER"` | no |
| <a name="input_subnet_range_lan"></a> [subnet\_range\_lan](#input\_subnet\_range\_lan) | Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /29.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |
| <a name="input_subnet_range_mgmt"></a> [subnet\_range\_mgmt](#input\_subnet\_range\_mgmt) | Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |
| <a name="input_subnet_range_wan"></a> [subnet\_range\_wan](#input\_subnet\_range\_wan) | Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) Specifies the size of the Virtual Machine. See also Azure VM Naming Conventions. https://learn.microsoft.com/en-us/azure/virtual-machines/vm-naming-conventions | `string` | `"Standard_D8ls_v5"` | no |
| <a name="input_vnet_prefix"></a> [vnet\_prefix](#input\_vnet\_prefix) | Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_availability_set"></a> [azurerm\_availability\_set](#output\_azurerm\_availability\_set) | n/a |
| <a name="output_azurerm_route_id"></a> [azurerm\_route\_id](#output\_azurerm\_route\_id) | n/a |
| <a name="output_azurerm_virtual_network_id"></a> [azurerm\_virtual\_network\_id](#output\_azurerm\_virtual\_network\_id) | n/a |
| <a name="output_cato_license_site"></a> [cato\_license\_site](#output\_cato\_license\_site) | n/a |
| <a name="output_dns_servers_id"></a> [dns\_servers\_id](#output\_dns\_servers\_id) | n/a |
| <a name="output_lan_nic_association_id"></a> [lan\_nic\_association\_id](#output\_lan\_nic\_association\_id) | n/a |
| <a name="output_lan_nic_id"></a> [lan\_nic\_id](#output\_lan\_nic\_id) | n/a |
| <a name="output_lan_route_id"></a> [lan\_route\_id](#output\_lan\_route\_id) | n/a |
| <a name="output_lan_rt_association_id"></a> [lan\_rt\_association\_id](#output\_lan\_rt\_association\_id) | n/a |
| <a name="output_lan_sg_id"></a> [lan\_sg\_id](#output\_lan\_sg\_id) | n/a |
| <a name="output_lan_subnet_id"></a> [lan\_subnet\_id](#output\_lan\_subnet\_id) | n/a |
| <a name="output_mgmt_nic_association_id"></a> [mgmt\_nic\_association\_id](#output\_mgmt\_nic\_association\_id) | n/a |
| <a name="output_mgmt_nic_id"></a> [mgmt\_nic\_id](#output\_mgmt\_nic\_id) | n/a |
| <a name="output_mgmt_public_ip_id"></a> [mgmt\_public\_ip\_id](#output\_mgmt\_public\_ip\_id) | n/a |
| <a name="output_mgmt_rt_association_id"></a> [mgmt\_rt\_association\_id](#output\_mgmt\_rt\_association\_id) | n/a |
| <a name="output_mgmt_sg_id"></a> [mgmt\_sg\_id](#output\_mgmt\_sg\_id) | n/a |
| <a name="output_mgmt_subnet_id"></a> [mgmt\_subnet\_id](#output\_mgmt\_subnet\_id) | n/a |
| <a name="output_private_rt_id"></a> [private\_rt\_id](#output\_private\_rt\_id) | n/a |
| <a name="output_public_route_id"></a> [public\_route\_id](#output\_public\_route\_id) | n/a |
| <a name="output_public_rt_id"></a> [public\_rt\_id](#output\_public\_rt\_id) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_socket_site_id"></a> [socket\_site\_id](#output\_socket\_site\_id) | n/a |
| <a name="output_socket_site_serial"></a> [socket\_site\_serial](#output\_socket\_site\_serial) | n/a |
| <a name="output_wan_nic_association_id"></a> [wan\_nic\_association\_id](#output\_wan\_nic\_association\_id) | n/a |
| <a name="output_wan_nic_id"></a> [wan\_nic\_id](#output\_wan\_nic\_id) | n/a |
| <a name="output_wan_public_ip_id"></a> [wan\_public\_ip\_id](#output\_wan\_public\_ip\_id) | n/a |
| <a name="output_wan_rt_association_id"></a> [wan\_rt\_association\_id](#output\_wan\_rt\_association\_id) | n/a |
| <a name="output_wan_sg_id"></a> [wan\_sg\_id](#output\_wan\_sg\_id) | n/a |
| <a name="output_wan_subnet_id"></a> [wan\_subnet\_id](#output\_wan\_subnet\_id) | n/a |
<!-- END_TF_DOCS -->