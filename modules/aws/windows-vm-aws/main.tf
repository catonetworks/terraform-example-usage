data "aws_ami" "amazon_linux_23" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

module "prod_test_server" {
  count   = var.build_prod_test_server ? 1 : 0
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name                        = "prod-test-server"
  ami                         = data.aws_ami.amazon_linux_23.id
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  availability_zone           = element(module.production_vpc[0].azs, 0)
  subnet_id                   = element(module.production_vpc[0].private_subnets, 0)
  vpc_security_group_ids      = [module.prod_test_security_group[0].security_group_id]
  associate_public_ip_address = false
  create_eip                  = false
  create_iam_instance_profile = true
  iam_role_description        = "IAM Role for EC2 Prod Test Instance"
  iam_role_policies = {
    SSM = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  }
  hibernation        = false
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]
  tags = merge(var.tags, {
    Name = "prod-test-server"
  })
  private_ip = var.prod_test_server_private_ip
}

module "prod_test_security_group" {
  count   = var.build_prod_test_server ? 1 : 0
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "prod-test-security-group"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.production_vpc[0].vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = merge(var.tags, {
    Name = "prod-test-security-group"
  })
}