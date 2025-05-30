module "vpc1_internal_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.site_name}-vpc1-internal-security-group"
  description = "Security group for usage with EC2 instance in vpc1"
  vpc_id      = module.test-env-vpc-1.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp", "https-443-tcp","rdp-tcp", "rdp-udp"]
  egress_rules        = ["all-all"]

  tags = merge(var.tags, {
    Name = "vpc1_internal-security-group"
  })
}

module "vpc2_internal_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.site_name}-vpc2-internal-security-group"
  description = "Security group for usage with EC2 instance in vpc2"
  vpc_id      = module.test-env-vpc-2.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp", "https-443-tcp", "rdp-tcp", "rdp-udp"]
  egress_rules        = ["all-all"]

  tags = merge(var.tags, {
    Name = "vpc2_internal-security-group"
  })
}

module "vpc3_internal_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.site_name}-vpc3-internal-security-group"
  description = "Security group for usage with EC2 instance in vpc3"
  vpc_id      = module.test-env-vpc-3.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp", "https-443-tcp", "rdp-tcp", "rdp-udp"]
  egress_rules        = ["all-all"]

  tags = merge(var.tags, {
    Name = "vpc3_internal-security-group"
  })
}

module "vpc3_external_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.site_name}-vpc3-external-security-group"
  description = "Security group for usage with EC2 instance in vpc3"
  vpc_id      = module.test-env-vpc-3.vpc_id

  ingress_cidr_blocks = var.external_testing_range == null ? [] : var.external_testing_range
  ingress_rules       = ["http-80-tcp", "all-icmp", "https-443-tcp", "rdp-tcp", "rdp-udp", "ssh-tcp"]
  egress_rules        = ["http-80-tcp", "all-icmp", "https-443-tcp", "rdp-tcp", "rdp-udp", "ssh-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_with_cidr_blocks = [{
    from_port  = 443
    to_port    = 443
    protocol   = "udp"
    cidr_block = "0.0.0.0/0"
  }]


  tags = merge(var.tags, {
    Name = "vpc3_internal-security-group"
  })
}
