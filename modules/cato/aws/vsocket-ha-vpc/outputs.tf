output "sg_internal" {
  value = module.vsocket-aws-ha-vpc.sg_internal
}

# output "sg_external_mgmt" {
#   value = module.vsocket-aws-ha-vpc.sg_external_mgmt
# }

# output "sg_external_wan" {
#   value = module.vsocket-aws-ha-vpc.sg_external_wan
# }

output "mgmt_eni_primary_id" {
  value = module.vsocket-aws-ha-vpc.mgmt_eni_primary_id
}

output "wan_eni_primary_id" {
  value = module.vsocket-aws-ha-vpc.wan_eni_primary_id
}

output "lan_eni_primary_id" {
  value = module.vsocket-aws-ha-vpc.lan_eni_primary_id
}

output "mgmt_eni_secondary_id" {
  value = module.vsocket-aws-ha-vpc.mgmt_eni_secondary_id
}

output "wan_eni_secondary_id" {
  value = module.vsocket-aws-ha-vpc.wan_eni_secondary_id
}

output "lan_eni_secondary_id" {
  value = module.vsocket-aws-ha-vpc.lan_eni_secondary_id
}

output "mgmteip_primary" {
  value = module.vsocket-aws-ha-vpc.mgmteip_primary
}

output "waneip_primary" {
  value = module.vsocket-aws-ha-vpc.waneip_primary
}

output "mgmteip_secondary" {
  value = module.vsocket-aws-ha-vpc.mgmteip_secondary
}

output "waneip_secondary" {
  value = module.vsocket-aws-ha-vpc.waneip_secondary
}

# output "mgmt_subnet_id" {
#   value = module.vsocket-aws-ha-vpc.mgmt_subnet_id
# }

# output "wan_subnet_id" {
#   value = module.vsocket-aws-ha-vpc.wan_subnet_id
# }

output "lan_subnet_primary_id" {
  value = module.vsocket-aws-ha-vpc.lan_subnet_primary_id
}

output "lan_subnet_secondary_id" {
  value = module.vsocket-aws-ha-vpc.lan_subnet_secondary_id
}

# output "mgmt_route_table_id" {
#   value = module.vsocket-aws-ha-vpc.mgmt_route_table_id
# }

output "wan_route_table_id" {
  value = module.vsocket-aws-ha-vpc.wan_route_table_id
}

output "lan_route_table_id" {
  value = module.vsocket-aws-ha-vpc.lan_route_table_id
}

output "aws_iam_role_name" {
  value = module.vsocket-aws-ha-vpc.aws_iam_role_name
}

output "aws_iam_policy_arn" {
  value = module.vsocket-aws-ha-vpc.aws_iam_policy_arn
}

output "aws_iam_instance_profile_name" {
  value = module.vsocket-aws-ha-vpc.aws_iam_instance_profile_name
}

output "aws_availability_zones_out" {
  value = module.vsocket-aws-ha-vpc.aws_availability_zones_out
}

# output "aws_instance_primary_vsocket_id" {
#   value = module.vsocket-aws-ha-vpc.aws_instance_primary_vsocket_id
# }

# output "aws_instance_secondary_vsocket_id" {
#   value = module.vsocket-aws-ha-vpc.aws_instance_secondary_vsocket_id
# }

output "internet_gateway_id" {
  value = module.vsocket-aws-ha-vpc.internet_gateway_id
}

output "vpc_id" {
  value = module.vsocket-aws-ha-vpc.vpc_id
}

output "cato_license_site" {
  value = module.vsocket-aws-ha-vpc.cato_license_site
}

# output "lan_subnet_primary_azid" {
#   description = "Primary LAN subnet ID serving internal applications"
#   value       = aws_subnet.lan_subnet_primary.availability_zone_id
# }

# output "lan_subnet_secondary_azid" {
#   description = "Secondary LAN subnet ID providing HA for internal traffic"
#   value       = aws_subnet.lan_subnet_secondary.availability_zone_id
# }

# output "mgmt_subnet_primary_id" {
#   description = "Subnet ID dedicated to management traffic for vSockets"
#   value       = aws_subnet.mgmt_subnet_primary.id
# }

# output "mgmt_subnet_secondary_id" {
#   description = "Subnet ID dedicated to management traffic for vSockets"
#   value       = aws_subnet.mgmt_subnet_secondary.id
# }

# output "wan_subnet_primary_id" {
#   description = "Subnet ID dedicated to WAN traffic for vSockets"
#   value       = aws_subnet.wan_subnet_primary.id
# }

# output "wan_subnet_secondary_id" {
#   description = "Subnet ID dedicated to WAN traffic for vSockets"
#   value       = aws_subnet.wan_subnet_secondary.id
# }

