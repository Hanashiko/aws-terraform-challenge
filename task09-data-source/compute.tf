resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.public.id

  vpc_security_group_ids = [data.aws_security_group.main.id]

  tags = {
    Name    = var.ec2_instance_name
    Project = var.project_id
  }
}
