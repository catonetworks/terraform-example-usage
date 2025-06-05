module "ipsec-aws-tgw" {
  source                              = "catonetworks/ipsec-aws-transit-gateway/cato"
  account_id                          = var.account_id
  token                               = var.token
  aws_transit_gateway_id              = module.transit-gateway.ec2_transit_gateway_id
  region                              = var.region
  cato_bgp_asn                        = var.cato_bgp_asn
  cato_primary_gateway_ip_address     = var.cato_primary_gateway_ip_address
  cato_secondary_gateway_ip_address   = var.cato_secondary_gateway_ip_address
  site_name                           = var.site_name
  site_description                    = var.site_description
  native_network_range                = var.native_network_range
  primary_vpn_tunnel1_inside_cidr     = var.primary_vpn_tunnel1_inside_cidr
  secondary_vpn_tunnel1_inside_cidr   = var.secondary_vpn_tunnel1_inside_cidr
  primary_vpn_tunnel1_preshared_key   = random_password.primary_vpn_tunnel1_preshared_key.result
  secondary_vpn_tunnel1_preshared_key = random_password.primary_vpn_tunnel1_preshared_key.result
  primary_vpn_tunnel2_preshared_key   = random_password.secondary_vpn_tunnel1_preshared_key.result
  secondary_vpn_tunnel2_preshared_key = random_password.secondary_vpn_tunnel1_preshared_key.result
  cato_primary_bgp_advertise_default_route = true
  cato_secondary_bgp_advertise_default_route = true


  #AWS Always takes the 1st IP in the Allocatied Subnet Range
  primary_private_cato_ip = var.primary_private_cato_ip
  primary_private_site_ip = var.primary_private_site_ip

  #AWS Always takes the 1st IP in the Allocatied Subnet Range
  secondary_private_cato_ip = var.secondary_private_cato_ip
  secondary_private_site_ip = var.secondary_private_site_ip

  downstream_bw = var.upstream_bw
  upstream_bw   = var.downstream_bw
  site_location = var.site_location

  tags = var.tags
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

module "test_env" {
  source = "../../../aws/test-env-tgw"
  count  = var.build_aws_ipsec_tgw_test_env ? 1 : 0

  site_name              = var.site_name
  tags                   = var.tags
  native_network_range   = var.native_network_range
  tgw_id                 = module.transit-gateway.ec2_transit_gateway_id
  keypair_name           = var.key_pair
  external_testing_range = var.external_testing_range
}

resource "random_password" "primary_vpn_tunnel1_preshared_key" {
  length  = 24
  special = true
  override_special = "._"
}

resource "random_password" "secondary_vpn_tunnel1_preshared_key" {
  length  = 24
  special = true
  override_special = "._"
}
