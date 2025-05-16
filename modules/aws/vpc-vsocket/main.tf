
resource "aws_vpc" "cato-lab" {
  cidr_block = var.vpc_range
  tags = {
    Name = "${var.site_name}-VPC"
  }
}

# Lookup data from region and VPC
data "aws_availability_zones" "available" {
  state = "available"
}

# Internet Gateway and Attachment
resource "aws_internet_gateway" "internet_gateway" {}

resource "aws_internet_gateway_attachment" "attach_gateway" {
  internet_gateway_id = aws_internet_gateway.internet_gateway.id
  vpc_id              = aws_vpc.cato-lab.id
}

# Subnets
resource "aws_subnet" "mgmt_subnet" {
  vpc_id            = aws_vpc.cato-lab.id
  cidr_block        = var.subnet_range_mgmt
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.site_name}-MGMT-Subnet"
  }
}

resource "aws_subnet" "wan_subnet" {
  vpc_id            = aws_vpc.cato-lab.id
  cidr_block        = var.subnet_range_wan
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.site_name}-WAN-Subnet"
  }
}

resource "aws_subnet" "lan_subnet" {
  vpc_id            = aws_vpc.cato-lab.id
  cidr_block        = var.subnet_range_lan
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.site_name}-LAN-Subnet"
  }
}

# Internal and External Security Groups
resource "aws_security_group" "internal_sg" {
  name        = "${var.site_name}-Internal-SG"
  description = "CATO LAN Security Group - Allow all traffic Inbound"
  vpc_id      = aws_vpc.cato-lab.id
  ingress = [
    {
      description      = "Allow all traffic Inbound from Ingress CIDR Blocks"
      protocol         = -1
      from_port        = 0
      to_port          = 0
      cidr_blocks      = var.ingress_cidr_blocks
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      description      = "Allow all traffic Outbound"
      protocol         = -1
      from_port        = 0
      to_port          = 0
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  tags = {
    name = "${var.site_name}-Internal-SG"
  }
}

resource "aws_security_group" "external_sg" {
  name        = "${var.site_name}-External-SG"
  description = "CATO WAN Security Group - Allow HTTPS In"
  vpc_id      = aws_vpc.cato-lab.id
  ingress = [
    {
      description      = "Allow HTTPS In"
      protocol         = "tcp"
      from_port        = 443
      to_port          = 443
      cidr_blocks      = var.ingress_cidr_blocks
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow SSH In"
      protocol         = "tcp"
      from_port        = 22
      to_port          = 22
      cidr_blocks      = var.ingress_cidr_blocks
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      description      = "Allow all traffic Outbound"
      protocol         = -1
      from_port        = 0
      to_port          = 0
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  tags = {
    name = "${var.site_name}-External-SG"
  }
}

# vSocket Network Interfaces
resource "aws_network_interface" "mgmteni" {
  source_dest_check = "true"
  subnet_id         = aws_subnet.mgmt_subnet.id
  private_ips       = [var.mgmt_eni_ip]
  security_groups   = [aws_security_group.external_sg.id]
  tags = {
    Name = "${var.site_name}-MGMT-INT"
  }
}

resource "aws_network_interface" "waneni" {
  source_dest_check = "true"
  subnet_id         = aws_subnet.wan_subnet.id
  private_ips       = [var.wan_eni_ip]
  security_groups   = [aws_security_group.external_sg.id]
  tags = {
    Name = "${var.site_name}-WAN-INT"
  }
}

resource "aws_network_interface" "laneni" {
  source_dest_check = "false"
  subnet_id         = aws_subnet.lan_subnet.id
  private_ips       = [var.lan_eni_ip]
  security_groups   = [aws_security_group.internal_sg.id]
  tags = {
    Name = "${var.site_name}-LAN-INT"
  }
}

# Elastic IP Addresses
resource "aws_eip" "wanip" {
  tags = {
    Name = "${var.site_name}-WAN-EIP"
  }
}

resource "aws_eip" "mgmteip" {
  tags = {
    Name = "${var.site_name}-MGMT-EIP"
  }
}

# Elastic IP Addresses Association - Required to properly destroy 
resource "aws_eip_association" "wanip_assoc" {
  network_interface_id = aws_network_interface.waneni.id
  allocation_id        = aws_eip.wanip.id
}

resource "aws_eip_association" "mgmteip_assoc" {
  network_interface_id = aws_network_interface.mgmteni.id
  allocation_id        = aws_eip.mgmteip.id
}

# Routing Tables
resource "aws_route_table" "extrt" {
  vpc_id = aws_vpc.cato-lab.id
  tags = {
    Name = "${var.site_name}-EXTERNAL-RT"
  }
}

resource "aws_route_table" "intrt" {
  vpc_id = aws_vpc.cato-lab.id
  tags = {
    Name = "${var.site_name}-INTERNAL-RT"
  }
}

# Routes
resource "aws_route" "ext_route" {
  route_table_id         = aws_route_table.extrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "int_route" {
  route_table_id         = aws_route_table.intrt.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.laneni.id
}

# Route Table Associations
resource "aws_route_table_association" "mgmt_subnet_route_table_association" {
  subnet_id      = aws_subnet.mgmt_subnet.id
  route_table_id = aws_route_table.extrt.id
}

resource "aws_route_table_association" "wan_subnet_route_table_association" {
  subnet_id      = aws_subnet.wan_subnet.id
  route_table_id = aws_route_table.extrt.id
}

resource "aws_route_table_association" "lan_subnet_route_table_association" {
  subnet_id      = aws_subnet.lan_subnet.id
  route_table_id = aws_route_table.intrt.id
}