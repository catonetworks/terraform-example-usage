output "sg_internal" {
  value = module.vsocket-aws-ha.sg_internal
}

output "sg_external_mgmt" {
  value = module.vsocket-aws-ha.sg_external_mgmt
}

output "sg_external_wan" {
  value = module.vsocket-aws-ha.sg_external_wan
}

output "mgmt_eni_primary_id" {
  value = module.vsocket-aws-ha.mgmt_eni_primary_id
}

output "wan_eni_primary_id" {
  value = module.vsocket-aws-ha.wan_eni_primary_id
}

output "lan_eni_primary_id" {
  value = module.vsocket-aws-ha.lan_eni_primary_id
}

output "mgmt_eni_secondary_id" {
  value = module.vsocket-aws-ha.mgmt_eni_secondary_id
}

output "wan_eni_secondary_id" {
  value = module.vsocket-aws-ha.wan_eni_secondary_id
}

output "lan_eni_secondary_id" {
  value = module.vsocket-aws-ha.lan_eni_secondary_id
}

output "mgmteip_primary" {
  value = module.vsocket-aws-ha.mgmteip_primary
}

output "waneip_primary" {
  value = module.vsocket-aws-ha.waneip_primary
}

output "mgmteip_secondary" {
  value = module.vsocket-aws-ha.mgmteip_secondary
}

output "waneip_secondary" {
  value = module.vsocket-aws-ha.waneip_secondary
}

output "mgmt_subnet_id" {
  value = module.vsocket-aws-ha.mgmt_subnet_id
}

output "wan_subnet_id" {
  value = module.vsocket-aws-ha.wan_subnet_id
}

output "lan_subnet_primary_id" {
  value = module.vsocket-aws-ha.lan_subnet_primary_id
}

output "lan_subnet_secondary_id" {
  value = module.vsocket-aws-ha.lan_subnet_secondary_id
}

output "mgmt_route_table_id" {
  value = module.vsocket-aws-ha.mgmt_route_table_id
}

output "wan_route_table_id" {
  value = module.vsocket-aws-ha.wan_route_table_id
}

output "lan_route_table_id" {
  value = module.vsocket-aws-ha.lan_route_table_id
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

output "aws_availability_zones_out" {
  value = module.vsocket-aws-ha.aws_availability_zones_out
}

# output "aws_instance_primary_vsocket_id" {
#   value = module.vsocket-aws-ha.aws_instance_primary_vsocket_id
# }

# output "aws_instance_secondary_vsocket_id" {
#   value = module.vsocket-aws-ha.aws_instance_secondary_vsocket_id
# }

output "internet_gateway_id" {
  value = module.vsocket-aws-ha.internet_gateway_id
}

output "vpc_id" {
  value = module.vsocket-aws-ha.vpc_id
}

output "cato_license_site" {
  value = module.vsocket-aws-ha.cato_license_site
}