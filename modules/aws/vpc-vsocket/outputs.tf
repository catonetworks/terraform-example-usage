## The following attributes are exported:
output "internet_gateway_id" { value = aws_internet_gateway.internet_gateway.id }
output "sg_internal" { value = aws_security_group.internal_sg.id }
output "sg_external" { value = aws_security_group.external_sg.id }
output "mgmt_eni_id" { value = aws_network_interface.mgmteni.id }
output "wan_eni_id" { value = aws_network_interface.waneni.id }
output "lan_eni_id" { value = aws_network_interface.laneni.id }
output "lan_subnet_id" { value = aws_subnet.lan_subnet.id }
output "vpc_id" { value = aws_vpc.cato-lab.id }
output "mgmt_network_interface" {
  description = "Details of the Management Network Interface"
  value = {
    id         = aws_network_interface.mgmteni.id
    private_ip = aws_network_interface.mgmteni.private_ip
    subnet_id  = aws_network_interface.mgmteni.subnet_id
    tags       = aws_network_interface.mgmteni.tags
  }
}

output "wan_network_interface" {
  description = "Details of the WAN Network Interface"
  value = {
    id         = aws_network_interface.waneni.id
    private_ip = aws_network_interface.waneni.private_ip
    subnet_id  = aws_network_interface.waneni.subnet_id
    tags       = aws_network_interface.waneni.tags
  }
}

output "lan_network_interface" {
  description = "Details of the LAN Network Interface"
  value = {
    id         = aws_network_interface.laneni.id
    private_ip = aws_network_interface.laneni.private_ip
    subnet_id  = aws_network_interface.laneni.subnet_id
    tags       = aws_network_interface.laneni.tags
  }
}

# Outputs for Elastic IPs
output "wan_elastic_ip" {
  description = "Details of the WAN Elastic IP"
  value = {
    id            = aws_eip.wanip.id
    public_ip     = aws_eip.wanip.public_ip
    allocation_id = aws_eip.wanip.allocation_id
    tags          = aws_eip.wanip.tags
  }
}

output "mgmt_elastic_ip" {
  description = "Details of the Management Elastic IP"
  value = {
    id            = aws_eip.mgmteip.id
    public_ip     = aws_eip.mgmteip.public_ip
    allocation_id = aws_eip.mgmteip.allocation_id
    tags          = aws_eip.mgmteip.tags
  }
}

# Outputs for Elastic IP Associations
output "wan_eip_association" {
  description = "Details of the WAN Elastic IP Association"
  value = {
    id                   = aws_eip_association.wanip_assoc.id
    network_interface_id = aws_eip_association.wanip_assoc.network_interface_id
    allocation_id        = aws_eip_association.wanip_assoc.allocation_id
  }
}

output "mgmt_eip_association" {
  description = "Details of the Management Elastic IP Association"
  value = {
    id                   = aws_eip_association.mgmteip_assoc.id
    network_interface_id = aws_eip_association.mgmteip_assoc.network_interface_id
    allocation_id        = aws_eip_association.mgmteip_assoc.allocation_id
  }
}

# Outputs for Route Tables
output "external_route_table" {
  description = "Details of the External Route Table"
  value = {
    id     = aws_route_table.extrt.id
    vpc_id = aws_route_table.extrt.vpc_id
    tags   = aws_route_table.extrt.tags
  }
}

output "internal_route_table" {
  description = "Details of the Internal Route Table"
  value = {
    id     = aws_route_table.intrt.id
    vpc_id = aws_route_table.intrt.vpc_id
    tags   = aws_route_table.intrt.tags
  }
}

# Outputs for Routes
output "ext_route" {
  description = "Details of the External Route"
  value = {
    route_table_id         = aws_route.ext_route.route_table_id
    destination_cidr_block = aws_route.ext_route.destination_cidr_block
    gateway_id             = aws_route.ext_route.gateway_id
  }
}

output "int_route" {
  description = "Details of the Internal Route"
  value = {
    route_table_id         = aws_route.int_route.route_table_id
    destination_cidr_block = aws_route.int_route.destination_cidr_block
    network_interface_id   = aws_route.int_route.network_interface_id
  }
}

# Outputs for Route Table Associations
output "mgmt_subnet_route_table_association" {
  description = "Details of the Management Subnet Route Table Association"
  value = {
    id             = aws_route_table_association.mgmt_subnet_route_table_association.id
    subnet_id      = aws_route_table_association.mgmt_subnet_route_table_association.subnet_id
    route_table_id = aws_route_table_association.mgmt_subnet_route_table_association.route_table_id
  }
}

output "wan_subnet_route_table_association" {
  description = "Details of the WAN Subnet Route Table Association"
  value = {
    id             = aws_route_table_association.wan_subnet_route_table_association.id
    subnet_id      = aws_route_table_association.wan_subnet_route_table_association.subnet_id
    route_table_id = aws_route_table_association.wan_subnet_route_table_association.route_table_id
  }
}

output "lan_subnet_route_table_association" {
  description = "Details of the LAN Subnet Route Table Association"
  value = {
    id             = aws_route_table_association.lan_subnet_route_table_association.id
    subnet_id      = aws_route_table_association.lan_subnet_route_table_association.subnet_id
    route_table_id = aws_route_table_association.lan_subnet_route_table_association.route_table_id
  }
}

output "lan_subnet_route_table_id" { value = aws_route_table.intrt.id }
output "lan_subnet_azid" { value = aws_subnet.lan_subnet.availability_zone }