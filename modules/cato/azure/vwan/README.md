<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_cato"></a> [cato](#requirement\_cato) | >= 0.0.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cato_azure_vwan_connection-1"></a> [cato\_azure\_vwan\_connection-1](#module\_cato\_azure\_vwan\_connection-1) | catonetworks/azure-vwan/cato | n/a |
| <a name="module_cato_azure_vwan_connection-2"></a> [cato\_azure\_vwan\_connection-2](#module\_cato\_azure\_vwan\_connection-2) | catonetworks/azure-vwan/cato | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.azure-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_hub.virtualhub-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) | resource |
| [azurerm_virtual_hub.virtualhub-2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) | resource |
| [azurerm_virtual_wan.virtualwan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The Account ID for the Cato Management Application. | `string` | n/a | yes |
| <a name="input_az_virtual_wan_name"></a> [az\_virtual\_wan\_name](#input\_az\_virtual\_wan\_name) | The name for the Azure Virtual WAN | `string` | `"Azure-Cato-vWAN-Site-VWAN"` | no |
| <a name="input_az_virtualhub_1_address_prefix"></a> [az\_virtualhub\_1\_address\_prefix](#input\_az\_virtualhub\_1\_address\_prefix) | The IP Address Cidr for Hub1 | `string` | `"10.55.0.0/17"` | no |
| <a name="input_az_virtualhub_1_name"></a> [az\_virtualhub\_1\_name](#input\_az\_virtualhub\_1\_name) | The name for Hub 1 | `string` | `"Azure-Cato-vWAN-Site-HUB1"` | no |
| <a name="input_az_virtualhub_2_address_prefix"></a> [az\_virtualhub\_2\_address\_prefix](#input\_az\_virtualhub\_2\_address\_prefix) | The IP Address Cidr for Hub2 | `string` | `"10.55.128.0/17"` | no |
| <a name="input_az_virtualhub_2_name"></a> [az\_virtualhub\_2\_name](#input\_az\_virtualhub\_2\_name) | The name for Hub 2 | `string` | `"Azure-Cato-vWAN-Site-HUB2"` | no |
| <a name="input_azure_asn"></a> [azure\_asn](#input\_azure\_asn) | Private ASN for Azure Side | `number` | `65003` | no |
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | The name of the existing Azure Resource Group where the VWAN Hub resides. | `string` | `"Azure-Cato-vWAN-Site-Resource-Group"` | no |
| <a name="input_baseurl"></a> [baseurl](#input\_baseurl) | The base URL for the Cato API. | `string` | `"https://api.catonetworks.com/api/v1/graphql"` | no |
| <a name="input_cato_asn"></a> [cato\_asn](#input\_cato\_asn) | Private ASN for Cato Side | `number` | `65002` | no |
| <a name="input_hub1_azure_primary_bgp_ip"></a> [hub1\_azure\_primary\_bgp\_ip](#input\_hub1\_azure\_primary\_bgp\_ip) | Private IP Address for BGP on Azure Side | `string` | `"169.254.21.5"` | no |
| <a name="input_hub1_azure_secondary_bgp_ip"></a> [hub1\_azure\_secondary\_bgp\_ip](#input\_hub1\_azure\_secondary\_bgp\_ip) | Private IP Address for BGP on Azure Side | `string` | `"169.254.22.5"` | no |
| <a name="input_hub1_cato_primary_bgp_ip"></a> [hub1\_cato\_primary\_bgp\_ip](#input\_hub1\_cato\_primary\_bgp\_ip) | Private IP Address for BGP on Cato Side | `string` | `"169.254.21.6"` | no |
| <a name="input_hub1_cato_secondary_bgp_ip"></a> [hub1\_cato\_secondary\_bgp\_ip](#input\_hub1\_cato\_secondary\_bgp\_ip) | Private IP Address for BGP on Cato Side | `string` | `"169.254.22.6"` | no |
| <a name="input_hub1_downstream_bw"></a> [hub1\_downstream\_bw](#input\_hub1\_downstream\_bw) | The downstream bandwidth in Mbps. | `number` | `25` | no |
| <a name="input_hub1_location"></a> [hub1\_location](#input\_hub1\_location) | The Azure Region in which to deploy Hub1 | `string` | n/a | yes |
| <a name="input_hub1_tags"></a> [hub1\_tags](#input\_hub1\_tags) | A map of tags to apply to all taggable Azure resources. | `map(string)` | `{}` | no |
| <a name="input_hub1_upstream_bw"></a> [hub1\_upstream\_bw](#input\_hub1\_upstream\_bw) | The upstream bandwidth in Mbps. | `number` | `25` | no |
| <a name="input_hub2_azure_primary_bgp_ip"></a> [hub2\_azure\_primary\_bgp\_ip](#input\_hub2\_azure\_primary\_bgp\_ip) | Private IP Address for BGP on Azure Side | `string` | `"169.254.21.9"` | no |
| <a name="input_hub2_azure_secondary_bgp_ip"></a> [hub2\_azure\_secondary\_bgp\_ip](#input\_hub2\_azure\_secondary\_bgp\_ip) | Private IP Address for BGP on Azure Side | `string` | `"169.254.22.9"` | no |
| <a name="input_hub2_cato_primary_bgp_ip"></a> [hub2\_cato\_primary\_bgp\_ip](#input\_hub2\_cato\_primary\_bgp\_ip) | Private IP Address for BGP on Cato Side | `string` | `"169.254.21.10"` | no |
| <a name="input_hub2_cato_secondary_bgp_ip"></a> [hub2\_cato\_secondary\_bgp\_ip](#input\_hub2\_cato\_secondary\_bgp\_ip) | Private IP Address for BGP on Cato Side | `string` | `"169.254.22.10"` | no |
| <a name="input_hub2_downstream_bw"></a> [hub2\_downstream\_bw](#input\_hub2\_downstream\_bw) | The downstream bandwidth in Mbps. | `number` | `25` | no |
| <a name="input_hub2_location"></a> [hub2\_location](#input\_hub2\_location) | The Azure Region in which to deploy Hub2 | `string` | n/a | yes |
| <a name="input_hub2_tags"></a> [hub2\_tags](#input\_hub2\_tags) | A map of tags to apply to all taggable Azure resources. | `map(string)` | `{}` | no |
| <a name="input_hub2_upstream_bw"></a> [hub2\_upstream\_bw](#input\_hub2\_upstream\_bw) | The upstream bandwidth in Mbps. | `number` | `25` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region for the provider | `string` | n/a | yes |
| <a name="input_native_network_range"></a> [native\_network\_range](#input\_native\_network\_range) | The native network range for the site. If null, it will be automatically populated from the Azure Hub's address prefix. | `string` | `null` | no |
| <a name="input_primary_cato_pop_ip"></a> [primary\_cato\_pop\_ip](#input\_primary\_cato\_pop\_ip) | The public IP address of the primary Cato PoP. Must match the name of an allocated IP in Cato. | `string` | n/a | yes |
| <a name="input_secondary_cato_pop_ip"></a> [secondary\_cato\_pop\_ip](#input\_secondary\_cato\_pop\_ip) | The public IP address of the secondary Cato PoP. Must match the name of an allocated IP in Cato. If null, a secondary connection will not be configured. | `string` | `null` | no |
| <a name="input_site_description"></a> [site\_description](#input\_site\_description) | A description for the site in the Cato Management Application. | `string` | `"Azure-Cato-vWAN-Site"` | no |
| <a name="input_site_name"></a> [site\_name](#input\_site\_name) | The name of the site in the Cato Management Application. | `string` | `"Azure-Cato-vWAN-Site"` | no |
| <a name="input_site_type"></a> [site\_type](#input\_site\_type) | The type of the site in Cato (e.g., CLOUD\_DC). | `string` | `"CLOUD_DC"` | no |
| <a name="input_token"></a> [token](#input\_token) | The API token for the Cato Management Application. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->