module "vsocket-aws-tgw-ha" {
  source = "catonetworks/vsocket-aws-tgw-ha/cato"

  token             = var.token
  account_id        = var.account_id
  key_pair          = var.key_pair
  vpc_network_range = var.vpc_network_range

  # | Subnet Purpose     | Index (N)     | CIDR Subnet     | 6th IP in Subnet     |
  # | ------------------ | ------------- | --------------- | -------------------- |
  # | MGMT Primary       | 0             | 10.0.0.0/28     | 10.0.0.6             |
  # | MGMT Secondary     | 1             | 10.0.0.16/28    | 10.0.0.22            |
  # | WAN Primary        | 2             | 10.0.0.32/28    | 10.0.0.38            |
  # | WAN Secondary      | 3             | 10.0.0.48/28    | 10.0.0.54            |
  # | LAN Primary        | 4             | 10.0.0.64/28    | 10.0.0.70            |
  # | LAN Secondary      | 5             | 10.0.0.80/28    | 10.0.0.86            |
  # | TGW Primary        | 6             | 10.0.0.96/28    | 10.0.0.102           |
  # | TGW Secondary      | 7             | 10.0.0.112/28   | 10.0.0.118           |

  # Subnet blocks
  subnet_range_mgmt_primary   = var.subnet_range_mgmt_primary == null ? cidrsubnet(var.vpc_network_range, 4, 0) : var.subnet_range_mgmt_primary
  subnet_range_mgmt_secondary = var.subnet_range_mgmt_secondary == null ? cidrsubnet(var.vpc_network_range, 4, 1) : var.subnet_range_mgmt_secondary
  subnet_range_wan_primary    = var.subnet_range_wan_primary == null ? cidrsubnet(var.vpc_network_range, 4, 2) : var.subnet_range_wan_primary
  subnet_range_wan_secondary  = var.subnet_range_wan_secondary == null ? cidrsubnet(var.vpc_network_range, 4, 3) : var.subnet_range_wan_secondary
  subnet_range_lan_primary    = var.subnet_range_lan_primary == null ? cidrsubnet(var.vpc_network_range, 4, 4) : var.subnet_range_lan_primary
  subnet_range_lan_secondary  = var.subnet_range_lan_secondary == null ? cidrsubnet(var.vpc_network_range, 4, 5) : var.subnet_range_lan_secondary
  subnet_range_tgw_primary    = var.subnet_range_tgw_primary == null ? cidrsubnet(var.vpc_network_range, 4, 6) : var.subnet_range_tgw_primary
  subnet_range_tgw_secondary  = var.subnet_range_tgw_secondary == null ? cidrsubnet(var.vpc_network_range, 4, 7) : var.subnet_range_tgw_secondary

  # 6th usable IPs in each subnet
  mgmt_eni_primary_ip   = var.mgmt_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 4, 0), 6) : var.mgmt_eni_primary_ip
  mgmt_eni_secondary_ip = var.mgmt_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 4, 1), 6) : var.mgmt_eni_secondary_ip
  wan_eni_primary_ip    = var.wan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 4, 2), 6) : var.wan_eni_primary_ip
  wan_eni_secondary_ip  = var.wan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 4, 3), 6) : var.wan_eni_secondary_ip
  lan_eni_primary_ip    = var.lan_eni_primary_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 4, 4), 6) : var.lan_eni_primary_ip
  lan_eni_secondary_ip  = var.lan_eni_secondary_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 4, 5), 6) : var.lan_eni_secondary_ip

  ingress_cidr_blocks = var.ingress_cidr_blocks
  site_name           = var.site_name
  tgw_id              = module.transit-gateway.ec2_transit_gateway_id
  tgw_route_table_id  = module.transit-gateway.ec2_transit_gateway_association_default_route_table_id
  site_description    = var.site_description
  region              = var.region
  tags                = var.tags

  build_default_tgw_route_to_cato = true

  routed_networks = var.build_aws_vsocket_tgw_ha_test_env ? {
    "test-env-vpc-1" = module.test_env_ha[0].vpc1_cidr_block
    "test-env-vpc-2" = module.test_env_ha[0].vpc2_cidr_block
    "test-env-vpc-3" = module.test_env_ha[0].vpc3_cidr_block
  } : {}
}

module "transit-gateway" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.13.0"

  name        = "${var.site_name}-TGW"
  description = "${var.site_name} Transit Gateway"

  amazon_side_asn                        = var.amazon_side_asn == null ? 64512 : var.amazon_side_asn
  enable_default_route_table_association = var.enable_default_route_table_association == null ? true : var.enable_default_route_table_association
  enable_default_route_table_propagation = var.enable_default_route_table_propagation == null ? true : var.enable_default_route_table_propagation
  enable_auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments == null ? false : var.enable_auto_accept_shared_attachments
  enable_multicast_support               = var.enable_multicast_support == null ? false : var.enable_multicast_support
  enable_vpn_ecmp_support                = var.enable_vpn_ecmp_support == null ? false : var.enable_vpn_ecmp_support
  enable_dns_support                     = var.enable_dns_support == null ? true : var.enable_dns_support
  transit_gateway_cidr_blocks            = var.transit_gateway_cidr_blocks == null ? null : var.transit_gateway_cidr_blocks
  enable_sg_referencing_support          = var.enable_sg_referencing_support == null ? false : var.enable_sg_referencing_support
  share_tgw                              = var.share_tgw == null ? false : var.share_tgw

  tgw_default_route_table_tags = {
    Name = "${var.site_name}-TGW-Default-RT"
  }

  tgw_route_table_tags = {
    Name = "${var.site_name}-TGW-RT"
  }

  tgw_vpc_attachment_tags = {
    Name = "${var.site_name}-TGW-VPC-Attachment"
  }

  create_tgw_routes = false
  tags              = var.tags
}

module "test_env_ha" {
  source = "../../../aws/test-env-tgw"
  count  = var.build_aws_vsocket_tgw_ha_test_env ? 1 : 0

  site_name              = var.site_name
  tags                   = var.tags
  native_network_range   = var.native_network_range
  tgw_id                 = module.transit-gateway.ec2_transit_gateway_id
  keypair_name           = var.key_pair
  external_testing_range = var.external_testing_range
  enable_kali            = var.enable_kali
  ### Needs a Custom AMI unless Marketplace has it enabled". Defaults to Null
  kali_ami_id = var.kali_ami_id

  ### Kali AMI IDs per Region: 
  # us-west-2 : ami-0395cfad13fba5338
  # us-west-1 : ami-09f6155bb6bc5e630
  # us-east-1 : ami-0ce17303563d46234
  # us-east-2 : ami-03756d73eb17f396b
  ### 
}
