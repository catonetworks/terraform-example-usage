# module.vsocket-aws-vpc outputs
output "internet_gateway_id" {
  value = module.vsocket-aws-vpc.internet_gateway_id
}

output "vpc_id" {
  value = module.vsocket-aws-vpc.vpc_id
}

output "sg_internal" {
  value = module.vsocket-aws-vpc.sg_internal
}

output "sg_external" {
  value = module.vsocket-aws-vpc.sg_external
}

output "mgmt_subnet_id" {
  value = module.vsocket-aws-vpc.mgmt_subnet_id
}

output "wan_subnet_id" {
  value = module.vsocket-aws-vpc.wan_subnet_id
}

output "lan_subnet_id" {
  value = module.vsocket-aws-vpc.lan_subnet_id
}

output "mgmt_eni_id" {
  value = module.vsocket-aws-vpc.mgmt_eni_id
}

output "wan_eni_id" {
  value = module.vsocket-aws-vpc.wan_eni_id
}

output "lan_eni_id" {
  value = module.vsocket-aws-vpc.lan_eni_id
}

output "internal_sg" {
  value = module.vsocket-aws-vpc.internal_sg
}

output "external_sg" {
  value = module.vsocket-aws-vpc.external_sg
}

output "mgmt_eip_id" {
  value = module.vsocket-aws-vpc.mgmt_eip_id
}

output "wan_eip_id" {
  value = module.vsocket-aws-vpc.wan_eip_id
}

output "socket_site_id" {
  value = module.vsocket-aws-vpc.socket_site_id
}

output "socket_site_serial" {
  value = module.vsocket-aws-vpc.socket_site_serial
}

output "vsocket_instance_id" {
  value = module.vsocket-aws-vpc.vsocket_instance_id
}

output "vsocket_instance_public_ip" {
  value = module.vsocket-aws-vpc.vsocket_instance_public_ip
}

output "vsocket_instance_ami" {
  value = module.vsocket-aws-vpc.vsocket_instance_ami
}

output "cato_site_name" {
  value = module.vsocket-aws-vpc.cato_site_name
}

output "native_network_range" {
  value = module.vsocket-aws-vpc.native_network_range
}

output "local_ip" {
  value = module.vsocket-aws-vpc.local_ip
}

output "cato_license_site" {
  value = module.vsocket-aws-vpc.cato_license_site
}

output "lan_subnet_route_table_id" {
  value = module.vsocket-aws-vpc.lan_subnet_route_table_id
}