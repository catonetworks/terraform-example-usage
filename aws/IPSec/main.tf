provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.10.16.0/20"
}

module "ipsec-aws" {
  source                    = "../../../terraform-cato-ipsec-aws"
  token                     = var.cato_token
  account_id                = var.account_id
  region                    = var.region
  bgp_asn                   = var.bgp_asn
  vpc_id                    = aws_vpc.main.id
  cgw_ip                    = var.cgw_ip
  site_name                 = var.site_name
  site_type                 = var.site_type
  site_description          = var.site_description
  native_network_range      = var.native_network_range
  site_location             = {
      city         = "New York City"
      country_code = "US"
      state_code   = "US-NY" ## Optional - for countries with states
      timezone     = "America/New_York"
    }
  primary_public_cato_ip_id = var.primary_public_cato_ip_id
  primary_private_cato_ip   = var.primary_private_cato_ip
  primary_private_site_ip   = var.primary_private_site_ip
  # primary_destination_type = var.primary_destination_type
  # primary_pop_location_id = var.primary_pop_location_id
  secondary_public_cato_ip_id = var.secondary_public_cato_ip_id
  secondary_private_cato_ip   = var.secondary_private_cato_ip
  secondary_private_site_ip   = var.secondary_private_site_ip
  # secondary_destination_type = var.secondary_destination_type
  # secondary_pop_location_id = var.secondary_pop_location_id
  downstream_bw = var.downstream_bw
  upstream_bw   = var.upstream_bw
}

# resource "aws_vpc" "main" {
#   cidr_block = var.native_network_range
# }

# provider "cato" {
#     baseurl = "https://api.catonetworks.com/api/v1/graphql2"
#     token = var.cato_token
#     account_id = var.account_id
# }

# # Create 2 allocated IPs in Cato, Get IDs

# resource "aws_customer_gateway" "cgw" {
#   bgp_asn    = var.bgp_asn
#   ip_address = var.cgw_ip
#   type       = "ipsec.1"
# }

# resource "aws_vpn_gateway" "vgw" {
#   vpc_id = var.vpc_id
# }

# resource "aws_vpn_connection" "vpn_connection" {
#   customer_gateway_id = aws_customer_gateway.cgw.id
#   vpn_gateway_id      = aws_vpn_gateway.vgw.id
#   type                = "ipsec.1"
# }

# # Create AWS resources first
# module "aws_vpn" {
#   source     = "./aws_vpn"
#   aws_region = var.aws_region
#   bgp_asn    = var.bgp_asn
#   vpc_id     = aws_vpc.main.id
#   cgw_ip     = var.cgw_ip
# }

# resource "cato_ipsec_site" "test-dev-site" {
#   name = var.site_name
#   site_type = var.site_type
#   description = var.site_description
#   native_network_range = var.native_network_range
#   site_location = var.site_location
#   ipsec = {
#     primary = {
#       # destination_type = ""
#       public_cato_ip_id = var.primary_public_cato_ip_id
#       # pop_location_id = ""
#       tunnels = [
#         {
#           public_site_ip = module.aws_vpn.tunnel1_address
#           private_cato_ip = var.primary_private_cato_ip
#           private_site_ip = var.primary_private_site_ip
#           psk = module.aws_vpn.tunnel1_preshared_key
#           last_mile_bw = {
#             downstream  = var.downstream_bw
#             upstream    = var.upstream_bw
#             # downstream_mbps_precision = 1
#             # upstream_mbps_precision = 1
#           }
#         }
#       ]
#     }
#     secondary = {
#       # destination_type = ""
#       public_cato_ip_id = var.secondary_public_cato_ip_id
#       # pop_location_id = ""
#       tunnels = [
#         {
#           public_site_ip = module.aws_vpn.tunnel2_address
#           private_cato_ip = var.secondary_private_cato_ip
#           private_site_ip = var.secondary_private_site_ip
#           psk = module.aws_vpn.tunnel2_preshared_key
#           last_mile_bw = {
#             downstream      = var.downstream_bw
#             upstream        = var.upstream_bw
#             # downstream_mbps_precision = 1
#             # upstream_mbps_precision = 1
#           }
#         }
#       ]
#     }    
#   }  
# }