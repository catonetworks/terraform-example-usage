# module.vpc outputs
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway associated with the VPC."
  value       = module.vpc.internet_gateway_id
}

output "sg_internal" {
  description = "The ID of the internal security group."
  value       = module.vpc.sg_internal
}

output "sg_external" {
  description = "The ID of the external security group."
  value       = module.vpc.sg_external
}

output "mgmt_eni_primary_id" {
  description = "The ID of the primary management network interface."
  value       = module.vpc.mgmt_eni_primary_id
}

output "wan_eni_primary_id" {
  description = "The ID of the primary WAN network interface."
  value       = module.vpc.wan_eni_primary_id
}

output "lan_eni_primary_id" {
  description = "The ID of the primary LAN network interface."
  value       = module.vpc.lan_eni_primary_id
}

output "mgmt_eni_secondary_id" {
  description = "The ID of the secondary management network interface."
  value       = module.vpc.mgmt_eni_secondary_id
}

output "wan_eni_secondary_id" {
  description = "The ID of the secondary WAN network interface."
  value       = module.vpc.wan_eni_secondary_id
}

output "lan_eni_secondary_id" {
  description = "The ID of the secondary LAN network interface."
  value       = module.vpc.lan_eni_secondary_id
}

output "mgmteip_primary" {
  description = "The public IP of the primary management Elastic IP."
  value       = module.vpc.mgmteip_primary
}

output "waneip_primary" {
  description = "The public IP of the primary WAN Elastic IP."
  value       = module.vpc.waneip_primary
}

output "mgmteip_secondary" {
  description = "The public IP of the secondary management Elastic IP."
  value       = module.vpc.mgmteip_secondary
}

output "waneip_secondary" {
  description = "The public IP of the secondary WAN Elastic IP."
  value       = module.vpc.waneip_secondary
}

output "mgmt_subnet_id" {
  description = "The ID of the management subnet."
  value       = module.vpc.mgmt_subnet_id
}

output "wan_subnet_id" {
  description = "The ID of the WAN subnet."
  value       = module.vpc.wan_subnet_id
}

output "lan_subnet_primary_id" {
  description = "The ID of the primary LAN subnet."
  value       = module.vpc.lan_subnet_primary_id
}

output "lan_subnet_secondary_id" {
  description = "The ID of the secondary LAN subnet."
  value       = module.vpc.lan_subnet_secondary_id
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "mgmt_route_table_id" {
  description = "The ID of the management route table."
  value       = module.vpc.mgmt_route_table_id
}

output "wan_route_table_id" {
  description = "The ID of the WAN route table."
  value       = module.vpc.wan_route_table_id
}

output "lan_route_table_id" {
  description = "The ID of the LAN route table."
  value       = module.vpc.lan_route_table_id
}

# module.vsocket-aws-ha outputs
output "socket_site_id" {
  value = module.vsocket-aws-ha.socket_site_id
}

output "socket_site_serial" {
  value = module.vsocket-aws-ha.socket_site_serial
}

output "secondary_socket_site_serial" {
  value = module.vsocket-aws-ha.secondary_socket_site_serial
}

output "aws_iam_role_name" {
  value = module.vsocket-aws-ha.aws_iam_role_name
}

output "aws_iam_policy_arn" {
  value = module.vsocket-aws-ha.aws_iam_policy_arn
}

output "aws_iam_instance_profile_name" {
  value = module.vsocket-aws-ha.aws_iam_instance_profile_name
}

output "aws_availability_zones" {
  value = module.vsocket-aws-ha.aws_availability_zones
}

output "aws_instance_primary_vsocket_id" {
  value = module.vsocket-aws-ha.aws_instance_primary_vsocket_id
}

output "aws_instance_secondary_vsocket_id" {
  value = module.vsocket-aws-ha.aws_instance_secondary_vsocket_id
}

output "cato_license_site" {
  value = module.vsocket-aws-ha.cato_license_site
}