<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_cato"></a> [cato](#requirement\_cato) | >= 0.0.30 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vsocket-azure-ha-vnet"></a> [vsocket-azure-ha-vnet](#module\_vsocket-azure-ha-vnet) | catonetworks/vsocket-azure-ha-vnet-2nic/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cato Networks Account ID | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_baseurl"></a> [baseurl](#input\_baseurl) | Cato Networks API URL | `string` | `"https://api.catonetworks.com/api/v1/graphql2"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Resource group creation true will create and false will use exsiting | `bool` | `true` | no |
| <a name="input_create_vnet"></a> [create\_vnet](#input\_create\_vnet) | Whether or not to create the Vnet, or use existing Vnet | `bool` | `true` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | n/a | `list(string)` | <pre>[<br/>  "10.254.254.1",<br/>  "168.63.129.16",<br/>  "1.1.1.1",<br/>  "8.8.8.8"<br/>]</pre> | no |
| <a name="input_downstream_bandwidth"></a> [downstream\_bandwidth](#input\_downstream\_bandwidth) | Sockets downstream interface WAN Bandwidth in Mbps | `string` | `"25"` | no |
| <a name="input_floating_ip"></a> [floating\_ip](#input\_floating\_ip) | Floating IP Address for the vSocket | `string` | `null` | no |
| <a name="input_lan_ip_primary"></a> [lan\_ip\_primary](#input\_lan\_ip\_primary) | Local IP Address of socket LAN interface | `string` | `null` | no |
| <a name="input_lan_ip_secondary"></a> [lan\_ip\_secondary](#input\_lan\_ip\_secondary) | Local IP Address of socket LAN interface | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | `"East US"` | no |
| <a name="input_resource_prefix_name"></a> [resource\_prefix\_name](#input\_resource\_prefix\_name) | Prefix used for Azure resource names. Must conform to Azure naming restrictions. | `string` | `null` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | Your site description | `string` | `"Azure Cato vSocket HA VNET 2Nic Site"` | no |
| <a name="input_site_location"></a> [site\_location](#input\_site\_location) | Site location which is used by the Cato Socket to connect to the closest Cato PoP. If not specified, the location will be derived from the Azure region dynamicaly. | <pre>object({<br/>    city         = string<br/>    country_code = string<br/>    state_code   = string<br/>    timezone     = string<br/>  })</pre> | <pre>{<br/>  "city": null,<br/>  "country_code": null,<br/>  "state_code": null,<br/>  "timezone": null<br/>}</pre> | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | Your Cato Site Name Here | `string` | `"Azure-Cato-vSocket-HA-VNET-2-NIC-Site"` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site | `string` | `"CLOUD_DC"` | no |
| <a name="input_subnet_range_lan"></a> [subnet\_range\_lan](#input\_subnet\_range\_lan) | Choose a range within the VPC to use as the Private/LAN subnet. This subnet will host the target LAN interface of the vSocket so resources in the VPC (or AWS Region) can route to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /29.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_mgmt"></a> [subnet\_range\_mgmt](#input\_subnet\_range\_mgmt) | Choose a range within the VPC to use as the Management subnet. This subnet will be used initially to access the public internet and register your vSocket to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_subnet_range_wan"></a> [subnet\_range\_wan](#input\_subnet\_range\_wan) | Choose a range within the VPC to use as the Public/WAN subnet. This subnet will be used to access the public internet and securely tunnel to the Cato Cloud.<br/>    The minimum subnet length to support High Availability is /28.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `null` | no |
| <a name="input_token"></a> [token](#input\_token) | Cato Networks API Token | `string` | n/a | yes |
| <a name="input_upstream_bandwidth"></a> [upstream\_bandwidth](#input\_upstream\_bandwidth) | Sockets upstream interface WAN Bandwidth in Mbps | `string` | `"25"` | no |
| <a name="input_vnet_prefix"></a> [vnet\_prefix](#input\_vnet\_prefix) | Choose a unique range for your new VPC that does not conflict with the rest of your Wide Area Network.<br/>    The accepted input format is Standard CIDR Notation, e.g. X.X.X.X/X | `string` | `"10.56.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->