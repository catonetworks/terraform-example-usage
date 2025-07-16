output "vpc1_id" {
  value       = module.test-env-vpc-1.vpc_id
  description = "VPC ID for VPC 1"
}

output "vpc2_id" {
  value       = module.test-env-vpc-2.vpc_id
  description = "VPC ID for VPC 2"
}

output "vpc3_id" {
  value       = module.test-env-vpc-3.vpc_id
  description = "VPC ID for VPC 3"
}

output "vpc1_cidr_block" {
  value       = module.test-env-vpc-1.vpc_cidr_block
  description = "CIDR Block for VPC 1"
}

output "vpc2_cidr_block" {
  value       = module.test-env-vpc-2.vpc_cidr_block
  description = "CIDR Block for VPC 2"
}

output "vpc3_cidr_block" {
  value       = module.test-env-vpc-3.vpc_cidr_block
  description = "CIDR Block for VPC 3"
}

output "vpc1_private_subnets" {
  value       = module.test-env-vpc-1.private_subnets
  description = "Private subnets for VPC 1"
}

output "vpc2_private_subnets" {
  value       = module.test-env-vpc-2.private_subnets
  description = "Private subnets for VPC 2"
}

output "vpc3_private_subnets" {
  value       = module.test-env-vpc-3.private_subnets
  description = "Private subnets for VPC 3"
}

output "vpc3_public_subnets" {
  value       = module.test-env-vpc-3.public_subnets
  description = "Public subnets for VPC 3"
}

output "ec2_instance_private_ips" {
  value = {
    for name, server in module.prod_test_servers : name => server.private_ip
  }
  description = "Private IPs of the deployed EC2 instances"
}

output "ec2_instance_ids" {
  value = {
    for name, server in module.prod_test_servers : name => server.id
  }
  description = "EC2 instance IDs of deployed servers"
}

output "ec2_instance_public_ips" {
  value = {
    for name, server in module.prod_test_servers : name => server.public_ip
  }
  description = "Public IPs of the EC2 instances that have public IPs"
}

output "vpc1_tgw_attachment_id" {
  value       = aws_ec2_transit_gateway_vpc_attachment.test-env-vpc-1-attach.id
  description = "Transit Gateway Attachment ID for VPC 1"
}

output "vpc2_tgw_attachment_id" {
  value       = aws_ec2_transit_gateway_vpc_attachment.test-env-vpc-2-attach.id
  description = "Transit Gateway Attachment ID for VPC 2"
}

output "ami_id" {
  value       = data.aws_ami.amazon_linux_23.id
  description = "AMI ID used for EC2 instances"
}

output "vpc3_public_ips" {
  description = "Public IPs of servers in VPC 3"
  value = {
    prod = {
      for name, server in module.prod_test_servers :
      name => server.public_ip
      if startswith(name, "test-env-vpc-3-")
    }
    windows = {
      for name, server in module.windows_test_servers :
      name => server.public_ip
      if startswith(name, "test-env-vpc-3-")
    }
  }
}