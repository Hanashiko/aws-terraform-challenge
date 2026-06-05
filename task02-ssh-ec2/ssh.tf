resource "aws_key_pair" "main" {
  key_name   = var.keypair_name
  public_key = var.ssh_key

  tags = {
    Name    = var.keypair_name
    Project = "epam-tf-lab"
    ID      = var.project_id
  }
}