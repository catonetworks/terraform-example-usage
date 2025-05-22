// AWS VPC and Virtual Socket Module
module "vsocket-aws-vpc-tgw" {
  source = "catonetworks/vsocket-aws-tgw/cato"

  ingress_cidr_blocks  = var.ingress_cidr_blocks
  key_pair             = var.key_pair
  vpc_network_range    = var.vpc_network_range
  native_network_range = var.native_network_range

  # | Subnet Purpose | CIDR            | ENI IP       |
  # | -------------- | --------------- | ------------ |
  # | MGMT           | `10.0.0.0/26`   | `10.0.0.6`   |
  # | WAN            | `10.0.0.64/26`  | `10.0.0.70`  |
  # | LAN            | `10.0.0.128/26` | `10.0.0.134` |
  # | TGW            | `10.0.0.192/26` | `10.0.0.198` |

  # Subnet blocks
  subnet_range_mgmt = var.subnet_range_mgmt == null ? cidrsubnet(var.vpc_network_range, 2, 0) : var.subnet_range_mgmt
  subnet_range_wan  = var.subnet_range_wan == null ? cidrsubnet(var.vpc_network_range, 2, 1) : var.subnet_range_wan
  subnet_range_lan  = var.subnet_range_lan == null ? cidrsubnet(var.vpc_network_range, 2, 2) : var.subnet_range_lan
  subnet_range_tgw  = var.subnet_range_tgw == null ? cidrsubnet(var.vpc_network_range, 2, 3) : var.subnet_range_tgw

  # 6th usable IPs in each subnet
  mgmt_eni_ip = var.mgmt_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 2, 0), 6) : var.mgmt_eni_ip
  wan_eni_ip  = var.wan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 2, 1), 6) : var.wan_eni_ip
  lan_eni_ip  = var.lan_eni_ip == null ? cidrhost(cidrsubnet(var.vpc_network_range, 2, 2), 6) : var.lan_eni_ip

  site_name          = var.site_name
  tgw_id             = module.transit-gateway.ec2_transit_gateway_id
  tgw_route_table_id = module.transit-gateway.ec2_transit_gateway_association_default_route_table_id
  site_description   = var.site_description
  site_location      = var.site_location
  tags               = var.tags

  depends_on = [module.transit-gateway]
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