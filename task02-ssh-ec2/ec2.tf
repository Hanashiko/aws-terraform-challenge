data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
  filter {
    name   = "availabilityZone"
    values = ["eu-west-1a"]
  }
}

data "aws_security_group" "main" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_name]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_ami" "amozon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "main" {
  ami                         = data.aws_ami.amozon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public.id
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [data.aws_security_group.main.id]

  tags = {
    Name    = var.instance_name
    Project = "epam-tf-lab"
    ID      = var.project_id
  }
}