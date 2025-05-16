# module.vpc outputs
output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "sg_internal" {
  value = module.vpc.sg_internal
}

output "sg_external" {
  value = module.vpc.sg_external
}

output "mgmt_eni_id" {
  value = module.vpc.mgmt_eni_id
}

output "wan_eni_id" {
  value = module.vpc.wan_eni_id
}

output "lan_eni_id" {
  value = module.vpc.lan_eni_id
}

output "lan_subnet_id" {
  value = module.vpc.lan_subnet_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "mgmt_network_interface" {
  value = module.vpc.mgmt_network_interface
}

output "wan_network_interface" {
  value = module.vpc.wan_network_interface
}

output "lan_network_interface" {
  value = module.vpc.lan_network_interface
}

output "wan_elastic_ip" {
  value = module.vpc.wan_elastic_ip
}

output "mgmt_elastic_ip" {
  value = module.vpc.mgmt_elastic_ip
}

output "wan_eip_association" {
  value = module.vpc.wan_eip_association
}

output "mgmt_eip_association" {
  value = module.vpc.mgmt_eip_association
}

output "external_route_table" {
  value = module.vpc.external_route_table
}

output "internal_route_table" {
  value = module.vpc.internal_route_table
}

output "ext_route" {
  value = module.vpc.ext_route
}

output "int_route" {
  value = module.vpc.int_route
}

output "mgmt_subnet_route_table_association" {
  value = module.vpc.mgmt_subnet_route_table_association
}

output "wan_subnet_route_table_association" {
  value = module.vpc.wan_subnet_route_table_association
}

output "lan_subnet_route_table_association" {
  value = module.vpc.lan_subnet_route_table_association
}

# module.vsocket-aws outputs
output "socket_site_id" {
  value       = module.vsocket-aws.socket_site_id
  description = "The Site ID of the Cato Networks Site (CMA)"
}

output "socket_site_serial" {
  value       = module.vsocket-aws.socket_site_serial
  description = "The Serial of the Cato Networks Socket"
}

output "vsocket_instance_id" {
  value       = module.vsocket-aws.vsocket_instance_id
  description = "The AWS Instance ID of the vSocket"
}

output "vsocket_instance_public_ip" {
  value       = module.vsocket-aws.vsocket_instance_public_ip
  description = "The Public IP of the vSocket"
}

output "vsocket_instance_ami" {
  value       = module.vsocket-aws.vsocket_instance_ami
  description = "The AMI used to build the vSocket"
}

output "cato_site_name" {
  value       = module.vsocket-aws.cato_site_name
  description = "The Site Name of the Cato Networks Site (CMA)"
}

output "native_network_range" {
  value       = module.vsocket-aws.native_network_range
  description = "The Native Network Range of the Cato Networks Site (CMA)"
}

output "local_ip" {
  value       = module.vsocket-aws.local_ip
  description = "The local IP of the Cato vSocket"
}

# output "cato_license_site" {
#   description = "Cato site license info"
#   value       = module.vsocket-aws.cato_license_site
# }