module "prod_test_servers" {
  for_each = {
    for server in local.servers : server.name => server
  }

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name                        = each.key
  ami                         = data.aws_ami.amazon_linux_23.id
  instance_type               = "t2.micro"
  key_name                    = var.keypair_name
  availability_zone           = each.value.az
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = [each.value.sg_id]
  associate_public_ip_address = each.value.associate_public_ip_address
  create_eip                  = false
  create_iam_instance_profile = true
  iam_role_description        = "IAM Role for EC2 Prod Test Instance"
  iam_role_policies = {
    SSM = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  }

  private_ip = each.value.private_ip

  root_block_device = [{
    encrypted   = false
    volume_type = "gp3"
    throughput  = 200
    volume_size = 50
    # tags = {
    #   Name = "root-disk"
    # }
  }]
  user_data = file("./templates/aws_al2023_user_data.tftpl")
  
  #   user_data = templatefile("./templates/aws_al2023_user_data.tftpl",
  # variable_name = thing 
  # Then in the file Ref with ${variable_name})
  
  tags = merge(var.tags, {
    Name = each.key
  })
}

module "windows_test_servers" {
  for_each = {
    for server in local.servers_windows : server.name => server
  }

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name                        = each.key
  ami                         = data.aws_ami.windows.id
  instance_type               = "t2.micro"
  key_name                    = var.keypair_name
  availability_zone           = each.value.az
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = [each.value.sg_id]
  associate_public_ip_address = each.value.associate_public_ip_address
  create_eip                  = false
  create_iam_instance_profile = true
  iam_role_description        = "IAM Role for EC2 Prod Test Instance"
  iam_role_policies = {
    SSM = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  }

  private_ip = each.value.private_ip

  root_block_device = [{
    encrypted   = false
    volume_type = "gp3"
    throughput  = 200
    volume_size = 5000
    # tags = {
    #   Name = "root-disk"
    # }
  }]
  user_data = file("./templates/aws_windows_user_data.tftpl")
  
  #   user_data = templatefile("./templates/aws_al2023_user_data.tftpl",{
  # region = var.region
  # })
  # Then in the file Ref with ${variable_name})
  
  tags = merge(var.tags, {
    Name = each.key
  })
}