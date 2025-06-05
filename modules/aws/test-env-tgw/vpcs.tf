module "test-env-vpc-1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name               = "${var.site_name}-TestEnv-VPC-1"
  cidr               = local.vpc1_cidr
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = local.vpc1_private_subnets
  enable_nat_gateway = var.vpc1_enable_nat_gateway
  enable_dns_support = var.vpc1_enable_dns_support

  tags = var.tags

}

resource "aws_route" "vpc1_private_to_tgw" {
  count = length(module.test-env-vpc-1.private_route_table_ids)

  route_table_id         = module.test-env-vpc-1.private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.tgw_id
}


resource "aws_ec2_transit_gateway_vpc_attachment" "test-env-vpc-1-attach" {
  vpc_id             = module.test-env-vpc-1.vpc_id
  transit_gateway_id = var.tgw_id
  subnet_ids         = module.test-env-vpc-1.private_subnets
  tags = merge(var.tags, {
  Name = "${var.site_name}-VPC1-TGW-Attachment" })
}

module "test-env-vpc-2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name               = "${var.site_name}-TestEnv-VPC-2"
  cidr               = local.vpc2_cidr
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = local.vpc2_private_subnets
  enable_nat_gateway = var.vpc2_enable_nat_gateway
  enable_dns_support = var.vpc2_enable_dns_support

  tags = var.tags

}

resource "aws_route" "vpc2_private_to_tgw" {
  count = length(module.test-env-vpc-1.private_route_table_ids)

  route_table_id         = module.test-env-vpc-2.private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.tgw_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "test-env-vpc-2-attach" {
  vpc_id             = module.test-env-vpc-2.vpc_id
  transit_gateway_id = var.tgw_id
  subnet_ids         = module.test-env-vpc-2.private_subnets
  tags = merge(var.tags, {
  Name = "${var.site_name}-VPC2-TGW-Attachment" })
}


module "test-env-vpc-3" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name               = "${var.site_name}-TestEnv-VPC-3"
  cidr               = local.vpc3_cidr
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = local.vpc3_private_subnets
  public_subnets     = local.vpc3_public_subnets
  enable_nat_gateway = var.vpc3_enable_nat_gateway
  enable_dns_support = var.vpc3_enable_dns_support

  tags = var.tags

}
