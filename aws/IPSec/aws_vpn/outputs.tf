output "vpn_connection_id" {
  description = "ID of the created AWS VPN connection"
  value       = aws_vpn_connection.vpn_connection.id
}

output "tunnel1_address" {
  value = aws_vpn_connection.vpn_connection.tunnel1_address
}

output "tunnel2_address" {
  value = aws_vpn_connection.vpn_connection.tunnel2_address
}

output "tunnel1_preshared_key" {
  value     = aws_vpn_connection.vpn_connection.tunnel1_preshared_key
  sensitive = true
}

output "tunnel2_preshared_key" {
  value     = aws_vpn_connection.vpn_connection.tunnel2_preshared_key
  sensitive = true
}
