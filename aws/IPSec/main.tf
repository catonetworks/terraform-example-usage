provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.10.16.0/20"
}

module "ipsec-aws" {
  source                    = "catonetworks/ipsec-aws/cato"
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
  secondary_public_cato_ip_id = var.secondary_public_cato_ip_id
  secondary_private_cato_ip   = var.secondary_private_cato_ip
  secondary_private_site_ip   = var.secondary_private_site_ip
  downstream_bw = var.downstream_bw
  upstream_bw   = var.upstream_bw
}
