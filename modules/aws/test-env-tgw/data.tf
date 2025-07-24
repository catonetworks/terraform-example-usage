data "aws_ami" "amazon_linux_23" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# Lookup data from region and VPC
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "windows" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["801119661308"]
}

data "aws_ami" "kali_linux" {
  most_recent = true
  owners      = ["679593333241"] # Offensive Security's account ID

  filter {
    name   = "name"
    values = ["kali-linux-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}