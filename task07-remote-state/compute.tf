resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.base_infra.outputs.public_subnet_id

  vpc_security_group_ids = [
    data.terraform_remote_state.base_infra.outputs.security_group_id
  ]

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}