<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.36.0 |
| <a name="requirement_cato"></a> [cato](#requirement\_cato) | >= 0.0.42 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cato_multisite_vwan"></a> [cato\_multisite\_vwan](#module\_cato\_multisite\_vwan) | catonetworks/azure-vwan-vsocket-ha/cato | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_create_resource_group"></a> [azure\_create\_resource\_group](#input\_azure\_create\_resource\_group) | Set to true to create a new resource group. If false, existing\_resource\_group\_name must be provided. | `bool` | `true` | no |
| <a name="input_azure_create_vwan"></a> [azure\_create\_vwan](#input\_azure\_create\_vwan) | Set to true to create a new Virtual WAN. If false, existing Virtual WAN will be used. | `bool` | `true` | no |
| <a name="input_azure_name_prefix"></a> [azure\_name\_prefix](#input\_azure\_name\_prefix) | A prefix to be used for naming all Azure resources. | `string` | `"Cato-vS-vWan"` | no |
| <a name="input_azure_primary_location"></a> [azure\_primary\_location](#input\_azure\_primary\_location) | The primary Azure region to deploy shared resources like the vWAN and Resource Group. | `string` | n/a | yes |
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | The name of the Azure Resource Group to create or use. | `string` | `"cato-vsocket-vwan-rg"` | no |
| <a name="input_azure_site1_create_hub"></a> [azure\_site1\_create\_hub](#input\_azure\_site1\_create\_hub) | Set to true to create a new Virtual WAN hub for site 1. | `bool` | `true` | no |
| <a name="input_azure_site1_hub_address_prefix"></a> [azure\_site1\_hub\_address\_prefix](#input\_azure\_site1\_hub\_address\_prefix) | The address prefix for the Virtual WAN hub for site 1. CIDR notation (e.g. 10.101.0.0/24). | `string` | `null` | no |
| <a name="input_azure_site1_hub_routing_preference"></a> [azure\_site1\_hub\_routing\_preference](#input\_azure\_site1\_hub\_routing\_preference) | Hub routing preference for site 1. Options: ASPath (default), ExpressRoute, or VpnGateway. | `string` | `"ASPath"` | no |
| <a name="input_azure_site1_location"></a> [azure\_site1\_location](#input\_azure\_site1\_location) | The Azure region for site 1. | `string` | n/a | yes |
| <a name="input_azure_site1_subnet_range_lan_cidr"></a> [azure\_site1\_subnet\_range\_lan\_cidr](#input\_azure\_site1\_subnet\_range\_lan\_cidr) | LAN/Private subnet range for site 1. Minimum /29 to support HA. CIDR notation (e.g. 10.1.3.0/24). | `string` | `null` | no |
| <a name="input_azure_site1_subnet_range_mgmt_cidr"></a> [azure\_site1\_subnet\_range\_mgmt\_cidr](#input\_azure\_site1\_subnet\_range\_mgmt\_cidr) | Management subnet range for site 1. Minimum /28 to support HA. CIDR notation (e.g. 10.1.1.0/24). | `string` | `null` | no |
| <a name="input_azure_site1_subnet_range_wan_cidr"></a> [azure\_site1\_subnet\_range\_wan\_cidr](#input\_azure\_site1\_subnet\_range\_wan\_cidr) | WAN/Public subnet range for site 1. Minimum /28 to support HA. CIDR notation (e.g. 10.1.2.0/24). | `string` | `null` | no |
| <a name="input_azure_site1_vnet_network_range_cidr"></a> [azure\_site1\_vnet\_network\_range\_cidr](#input\_azure\_site1\_vnet\_network\_range\_cidr) | Choose a unique range for site 1 Azure VNET that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.1.0.0/16). | `string` | `null` | no |
| <a name="input_azure_site2_create_hub"></a> [azure\_site2\_create\_hub](#input\_azure\_site2\_create\_hub) | Set to true to create a new Virtual WAN hub for site 2. | `bool` | `true` | no |
| <a name="input_azure_site2_hub_address_prefix"></a> [azure\_site2\_hub\_address\_prefix](#input\_azure\_site2\_hub\_address\_prefix) | The address prefix for the Virtual WAN hub for site 2. CIDR notation (e.g. 10.102.0.0/24). | `string` | `null` | no |
| <a name="input_azure_site2_hub_routing_preference"></a> [azure\_site2\_hub\_routing\_preference](#input\_azure\_site2\_hub\_routing\_preference) | Hub routing preference for site 2. Options: ASPath (default), ExpressRoute, or VpnGateway. | `string` | `"ASPath"` | no |
| <a name="input_azure_site2_location"></a> [azure\_site2\_location](#input\_azure\_site2\_location) | The Azure region for site 2. | `string` | n/a | yes |
| <a name="input_azure_site2_subnet_range_lan_cidr"></a> [azure\_site2\_subnet\_range\_lan\_cidr](#input\_azure\_site2\_subnet\_range\_lan\_cidr) | LAN/Private subnet range for site 2. Minimum /29 to support HA. CIDR notation (e.g. 10.2.3.0/24). | `string` | `null` | no |
| <a name="input_azure_site2_subnet_range_mgmt_cidr"></a> [azure\_site2\_subnet\_range\_mgmt\_cidr](#input\_azure\_site2\_subnet\_range\_mgmt\_cidr) | Management subnet range for site 2. Minimum /28 to support HA. CIDR notation (e.g. 10.2.1.0/24). | `string` | `null` | no |
| <a name="input_azure_site2_subnet_range_wan_cidr"></a> [azure\_site2\_subnet\_range\_wan\_cidr](#input\_azure\_site2\_subnet\_range\_wan\_cidr) | WAN/Public subnet range for site 2. Minimum /28 to support HA. CIDR notation (e.g. 10.2.2.0/24). | `string` | `null` | no |
| <a name="input_azure_site2_vnet_network_range_cidr"></a> [azure\_site2\_vnet\_network\_range\_cidr](#input\_azure\_site2\_vnet\_network\_range\_cidr) | Choose a unique range for site 2 Azure VNET that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.2.0.0/16). | `string` | `null` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | The Azure Subscription ID where resources will be deployed. | `string` | n/a | yes |
| <a name="input_baseurl"></a> [baseurl](#input\_baseurl) | Base URL for the Cato Networks API. | `string` | `"https://api.catonetworks.com/api/v1/graphql2"` | no |
| <a name="input_cato_account_id"></a> [cato\_account\_id](#input\_cato\_account\_id) | Your Cato Account ID. | `string` | n/a | yes |
| <a name="input_cato_bgp_asn"></a> [cato\_bgp\_asn](#input\_cato\_bgp\_asn) | The BGP Autonomous System Number for the Cato side of the peering. Must not conflict with Azure vWAN's fixed ASN 65515. | `number` | `65001` | no |
| <a name="input_cato_primary_bgp_advertise_all_routes"></a> [cato\_primary\_bgp\_advertise\_all\_routes](#input\_cato\_primary\_bgp\_advertise\_all\_routes) | Whether the primary BGP peer should advertise all routes. | `bool` | `true` | no |
| <a name="input_cato_primary_bgp_advertise_default_route"></a> [cato\_primary\_bgp\_advertise\_default\_route](#input\_cato\_primary\_bgp\_advertise\_default\_route) | Whether the primary BGP peer should advertise the default route. | `bool` | `false` | no |
| <a name="input_cato_primary_bgp_advertise_summary_route"></a> [cato\_primary\_bgp\_advertise\_summary\_route](#input\_cato\_primary\_bgp\_advertise\_summary\_route) | Whether the primary BGP peer should advertise summary routes. | `bool` | `false` | no |
| <a name="input_cato_primary_bgp_bfd_enabled"></a> [cato\_primary\_bgp\_bfd\_enabled](#input\_cato\_primary\_bgp\_bfd\_enabled) | Whether BFD is enabled for the primary BGP peer. | `bool` | `false` | no |
| <a name="input_cato_primary_bgp_default_action"></a> [cato\_primary\_bgp\_default\_action](#input\_cato\_primary\_bgp\_default\_action) | Default action for primary BGP peer routes. | `string` | `"ACCEPT"` | no |
| <a name="input_cato_primary_bgp_metric"></a> [cato\_primary\_bgp\_metric](#input\_cato\_primary\_bgp\_metric) | BGP metric for the primary peer. | `number` | `100` | no |
| <a name="input_cato_secondary_bgp_advertise_all_routes"></a> [cato\_secondary\_bgp\_advertise\_all\_routes](#input\_cato\_secondary\_bgp\_advertise\_all\_routes) | Whether the secondary BGP peer should advertise all routes. | `bool` | `true` | no |
| <a name="input_cato_secondary_bgp_advertise_default_route"></a> [cato\_secondary\_bgp\_advertise\_default\_route](#input\_cato\_secondary\_bgp\_advertise\_default\_route) | Whether the secondary BGP peer should advertise the default route. | `bool` | `false` | no |
| <a name="input_cato_secondary_bgp_default_action"></a> [cato\_secondary\_bgp\_default\_action](#input\_cato\_secondary\_bgp\_default\_action) | Default action for secondary BGP peer routes. | `string` | `"ACCEPT"` | no |
| <a name="input_cato_secondary_bgp_enabled"></a> [cato\_secondary\_bgp\_enabled](#input\_cato\_secondary\_bgp\_enabled) | Whether BFD is enabled for the secondary BGP peer. | `bool` | `false` | no |
| <a name="input_cato_secondary_bgp_metric"></a> [cato\_secondary\_bgp\_metric](#input\_cato\_secondary\_bgp\_metric) | BGP metric for the secondary peer. | `number` | `200` | no |
| <a name="input_cato_secondary_bgp_summary_route"></a> [cato\_secondary\_bgp\_summary\_route](#input\_cato\_secondary\_bgp\_summary\_route) | Whether the secondary BGP peer should advertise summary routes. | `bool` | `false` | no |
| <a name="input_cato_site1_floating_ip"></a> [cato\_site1\_floating\_ip](#input\_cato\_site1\_floating\_ip) | The floating IP address used for High Availability (HA) failover for site 1. | `string` | `null` | no |
| <a name="input_cato_site1_native_network_range_cidr"></a> [cato\_site1\_native\_network\_range\_cidr](#input\_cato\_site1\_native\_network\_range\_cidr) | Choose a unique range for site 1 that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.1.0.0/16). | `string` | `null` | no |
| <a name="input_cato_site1_primary_lan_ip"></a> [cato\_site1\_primary\_lan\_ip](#input\_cato\_site1\_primary\_lan\_ip) | Local IP Address of site 1 primary socket LAN interface. | `string` | `null` | no |
| <a name="input_cato_site1_secondary_lan_ip"></a> [cato\_site1\_secondary\_lan\_ip](#input\_cato\_site1\_secondary\_lan\_ip) | Local IP Address of site 1 secondary socket LAN interface. | `string` | `null` | no |
| <a name="input_cato_site1_site_description"></a> [cato\_site1\_site\_description](#input\_cato\_site1\_site\_description) | A brief description of site 1 for identification purposes. | `string` | `"Multi-regional Cato vSocket vWAN site 1"` | no |
| <a name="input_cato_site1_site_name"></a> [cato\_site1\_site\_name](#input\_cato\_site1\_site\_name) | The name of the Cato Networks site 1. | `string` | `"Azure-Cato-vS-vWAN-Site-HUB1"` | no |
| <a name="input_cato_site1_site_type"></a> [cato\_site1\_site\_type](#input\_cato\_site1\_site\_type) | The type of site 1 (DATACENTER, BRANCH, CLOUD\_DC, HEADQUARTERS). | `string` | `"CLOUD_DC"` | no |
| <a name="input_cato_site1_vm_size"></a> [cato\_site1\_vm\_size](#input\_cato\_site1\_vm\_size) | Specifies the size of the Virtual Machine for site 1. See Azure VM Naming Conventions. | `string` | `"Standard_D8ls_v5"` | no |
| <a name="input_cato_site2_floating_ip"></a> [cato\_site2\_floating\_ip](#input\_cato\_site2\_floating\_ip) | The floating IP address used for High Availability (HA) failover for site 2. | `string` | `null` | no |
| <a name="input_cato_site2_native_network_range_cidr"></a> [cato\_site2\_native\_network\_range\_cidr](#input\_cato\_site2\_native\_network\_range\_cidr) | Choose a unique range for site 2 that does not conflict with the rest of your Wide Area Network. CIDR notation (e.g. 10.2.0.0/16). | `string` | `null` | no |
| <a name="input_cato_site2_primary_lan_ip"></a> [cato\_site2\_primary\_lan\_ip](#input\_cato\_site2\_primary\_lan\_ip) | Local IP Address of site 2 primary socket LAN interface. | `string` | `null` | no |
| <a name="input_cato_site2_secondary_lan_ip"></a> [cato\_site2\_secondary\_lan\_ip](#input\_cato\_site2\_secondary\_lan\_ip) | Local IP Address of site 2 secondary socket LAN interface. | `string` | `null` | no |
| <a name="input_cato_site2_site_description"></a> [cato\_site2\_site\_description](#input\_cato\_site2\_site\_description) | A brief description of site 2 for identification purposes. | `string` | `"Multi-regional Cato vSocket site 2"` | no |
| <a name="input_cato_site2_site_name"></a> [cato\_site2\_site\_name](#input\_cato\_site2\_site\_name) | The name of the Cato Networks site 2. | `string` | `"Azure-Cato-vS-vWAN-Site-HUB2"` | no |
| <a name="input_cato_site2_site_type"></a> [cato\_site2\_site\_type](#input\_cato\_site2\_site\_type) | The type of site 2 (DATACENTER, BRANCH, CLOUD\_DC, HEADQUARTERS). | `string` | `"CLOUD_DC"` | no |
| <a name="input_cato_site2_vm_size"></a> [cato\_site2\_vm\_size](#input\_cato\_site2\_vm\_size) | Specifies the size of the Virtual Machine for site 2. See Azure VM Naming Conventions. | `string` | `"Standard_D8ls_v5"` | no |
| <a name="input_cato_token"></a> [cato\_token](#input\_cato\_token) | Cato Management API Token. | `string` | n/a | yes |
| <a name="input_deployment_subnet"></a> [deployment\_subnet](#input\_deployment\_subnet) | The overall CIDR block for the entire deployment. This will be automatically subdivided between sites and hubs. | `string` | `"10.57.0.0/16"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_infrastructure"></a> [azure\_infrastructure](#output\_azure\_infrastructure) | Azure infrastructure components created by the deployment |
| <a name="output_bgp_configuration"></a> [bgp\_configuration](#output\_bgp\_configuration) | BGP peering configuration and connection details |
| <a name="output_cato_sites"></a> [cato\_sites](#output\_cato\_sites) | Information about created Cato sites |
| <a name="output_deployment_config"></a> [deployment\_config](#output\_deployment\_config) | Configuration summary of the deployment |
| <a name="output_deployment_summary"></a> [deployment\_summary](#output\_deployment\_summary) | Comprehensive summary of deployed resources across all sites |
| <a name="output_deployment_validation"></a> [deployment\_validation](#output\_deployment\_validation) | Validation information to verify successful deployment |
| <a name="output_ha_configuration"></a> [ha\_configuration](#output\_ha\_configuration) | High Availability configuration details for both sites |
| <a name="output_network_configuration"></a> [network\_configuration](#output\_network\_configuration) | Detailed network configuration showing calculated and assigned ranges |
| <a name="output_resource_tags"></a> [resource\_tags](#output\_resource\_tags) | Tags applied to resources |
| <a name="output_virtual_machines"></a> [virtual\_machines](#output\_virtual\_machines) | Details about the deployed vSocket virtual machines |
| <a name="output_vwan_hubs"></a> [vwan\_hubs](#output\_vwan\_hubs) | Virtual WAN hub information and configuration |
<!-- END_TF_DOCS -->