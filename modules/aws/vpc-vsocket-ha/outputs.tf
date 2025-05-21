## The following attributes are exported:
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway associated with the VPC."
  value       = var.internet_gateway_id != null ? var.internet_gateway_id : aws_internet_gateway.internet_gateway[0].id
}

output "sg_internal" {
  description = "The ID of the internal security group."
  value       = aws_security_group.internal_sg.id
}

output "sg_external" {
  description = "The ID of the external security group."
  value       = aws_security_group.external_sg.id
}

output "mgmt_eni_primary_id" {
  description = "The ID of the primary management network interface."
  value       = aws_network_interface.mgmteni_primary.id
}

output "wan_eni_primary_id" {
  description = "The ID of the primary WAN network interface."
  value       = aws_network_interface.waneni_primary.id
}

output "lan_eni_primary_id" {
  description = "The ID of the primary LAN network interface."
  value       = aws_network_interface.laneni_primary.id
}

output "mgmt_eni_secondary_id" {
  description = "The ID of the secondary management network interface."
  value       = aws_network_interface.mgmteni_secondary.id
}

output "wan_eni_secondary_id" {
  description = "The ID of the secondary WAN network interface."
  value       = aws_network_interface.waneni_secondary.id
}

output "lan_eni_secondary_id" {
  description = "The ID of the secondary LAN network interface."
  value       = aws_network_interface.laneni_secondary.id
}

output "mgmteip_primary" {
  description = "The public IP of the primary management Elastic IP."
  value       = aws_eip.mgmteip_primary.public_ip
}

output "waneip_primary" {
  description = "The public IP of the primary WAN Elastic IP."
  value       = aws_eip.waneip_primary.public_ip
}

output "mgmteip_secondary" {
  description = "The public IP of the secondary management Elastic IP."
  value       = aws_eip.mgmteip_secondary.public_ip
}

output "waneip_secondary" {
  description = "The public IP of the secondary WAN Elastic IP."
  value       = aws_eip.waneip_secondary.public_ip
}

output "mgmt_subnet_primary_id" {
  description = "Subnet ID dedicated to management traffic for vSockets"
  value       = aws_subnet.mgmt_subnet_primary.id
}

output "mgmt_subnet_secondary_id" {
  description = "Subnet ID dedicated to management traffic for vSockets"
  value       = aws_subnet.mgmt_subnet_secondary.id
}

output "wan_subnet_primary_id" {
  description = "Subnet ID dedicated to WAN traffic for vSockets"
  value       = aws_subnet.wan_subnet_primary.id
}

output "wan_subnet_secondary_id" {
  description = "Subnet ID dedicated to WAN traffic for vSockets"
  value       = aws_subnet.wan_subnet_secondary.id
}

output "lan_subnet_primary_id" {
  description = "Primary LAN subnet ID serving internal applications"
  value       = aws_subnet.lan_subnet_primary.id
}

output "lan_subnet_secondary_id" {
  description = "Secondary LAN subnet ID providing HA for internal traffic"
  value       = aws_subnet.lan_subnet_secondary.id
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = var.vpc_id != null ? var.vpc_id : aws_vpc.cato-vpc[0].id
}

output "mgmt_route_table_id" {
  description = "The ID of the management route table."
  value       = aws_route_table.mgmtrt.id
}

output "wan_route_table_id" {
  description = "The ID of the WAN route table."
  value       = aws_route_table.wanrt.id
}

output "lan_route_table_id" {
  description = "The ID of the LAN route table."
  value       = aws_route_table.lanrt.id
}

output "lan_subnet_route_table_id" {
  value = aws_route_table.lanrt.id
}

output "lan_subnet_primary_azid" {
  description = "Primary LAN subnet ID serving internal applications"
  value       = aws_subnet.lan_subnet_primary.availability_zone_id
}

output "lan_subnet_secondary_azid" {
  description = "Secondary LAN subnet ID providing HA for internal traffic"
  value       = aws_subnet.lan_subnet_secondary.availability_zone_id
}
