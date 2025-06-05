locals {
  # Base ranges
  native = var.native_network_range

  # VPC 1 - 2nd /24 from native
  vpc1_cidr = var.vpc1_cidr_block != null ? var.vpc1_cidr_block : cidrsubnet(local.native, 8, 1)
  vpc1_private_subnets = [
    cidrsubnet(local.vpc1_cidr, 1, 0),
    cidrsubnet(local.vpc1_cidr, 1, 1)
  ]

  # VPC 2 - 3rd /24 from native
  vpc2_cidr = var.vpc2_cidr_block != null ? var.vpc2_cidr_block : cidrsubnet(local.native, 8, 2)
  vpc2_private_subnets = [
    cidrsubnet(local.vpc2_cidr, 1, 0),
    cidrsubnet(local.vpc2_cidr, 1, 1)
  ]

  # VPC 3 - 1st /23 from native
  vpc3_cidr = var.vpc3_cidr_block != null ? var.vpc3_cidr_block : cidrsubnet(local.native, 7, 2)
  vpc3_private_subnets = [
    cidrsubnet(local.vpc3_cidr, 2, 0),
    cidrsubnet(local.vpc3_cidr, 2, 1)
  ]
  vpc3_public_subnets = [
    cidrsubnet(local.vpc3_cidr, 2, 2),
    cidrsubnet(local.vpc3_cidr, 2, 3)
  ]
  servers = flatten([
    // VPC 1
    [
      for i, subnet in module.test-env-vpc-1.private_subnets_cidr_blocks : {
        name                        = "test-env-vpc-1-server-${i}"
        subnet_id                   = module.test-env-vpc-1.private_subnets[i]
        az                          = module.test-env-vpc-1.azs[i]
        sg_id                       = module.vpc1_internal_security_group.security_group_id
        private_ip                  = cidrhost(subnet, 6)
        associate_public_ip_address = false
      }
    ],

    // VPC 2
    [
      for i, subnet in module.test-env-vpc-2.private_subnets_cidr_blocks : {
        name                        = "test-env-vpc-2-server-${i}"
        subnet_id                   = module.test-env-vpc-2.private_subnets[i]
        az                          = module.test-env-vpc-2.azs[i]
        sg_id                       = module.vpc2_internal_security_group.security_group_id
        private_ip                  = cidrhost(subnet, 6)
        associate_public_ip_address = false
      }
    ],

    // VPC 3 - Public subnets with public IPs
    [
      for i, subnet in module.test-env-vpc-3.public_subnets_cidr_blocks : {
        name                        = "test-env-vpc-3-server-${i}"
        subnet_id                   = module.test-env-vpc-3.public_subnets[i]
        az                          = module.test-env-vpc-3.azs[i]
        sg_id                       = module.vpc3_external_security_group.security_group_id
        private_ip                  = cidrhost(subnet, 6)
        associate_public_ip_address = true
      }
    ]
  ])


  servers_windows = flatten([
    // VPC 1
    [
      for i, subnet in module.test-env-vpc-1.private_subnets_cidr_blocks : {
        name                        = "test-env-vpc-1-wserver-${i}"
        subnet_id                   = module.test-env-vpc-1.private_subnets[i]
        az                          = module.test-env-vpc-1.azs[i]
        sg_id                       = module.vpc1_internal_security_group.security_group_id
        private_ip                  = cidrhost(subnet, 7)
        associate_public_ip_address = false
      }
    ],

    // VPC 2
    [
      for i, subnet in module.test-env-vpc-2.private_subnets_cidr_blocks : {
        name                        = "test-env-vpc-2-wserver-${i}"
        subnet_id                   = module.test-env-vpc-2.private_subnets[i]
        az                          = module.test-env-vpc-2.azs[i]
        sg_id                       = module.vpc2_internal_security_group.security_group_id
        private_ip                  = cidrhost(subnet, 7)
        associate_public_ip_address = false
      }
    ],

    // VPC 3 - Public subnets with public IPs
    [
      for i, subnet in module.test-env-vpc-3.public_subnets_cidr_blocks : {
        name                        = "test-env-vpc-3-wserver-${i}"
        subnet_id                   = module.test-env-vpc-3.public_subnets[i]
        az                          = module.test-env-vpc-3.azs[i]
        sg_id                       = module.vpc3_external_security_group.security_group_id
        private_ip                  = cidrhost(subnet, 7)
        associate_public_ip_address = true
      }
    ]
  ])
}