resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.bgp_asn
  ip_address = var.cgw_ip
  type       = "ipsec.1"
}

resource "aws_vpn_gateway" "vgw" {
  vpc_id = var.vpc_id
}

resource "aws_vpn_connection" "vpn_connection" {
  customer_gateway_id = aws_customer_gateway.cgw.id
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  type                = "ipsec.1"
  
  # Tunnel options, you can configure your tunnel options here
}
