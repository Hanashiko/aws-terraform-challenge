data "aws_instance" "public" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private" {
  instance_id = var.private_instance_id
}

# ssh
resource "aws_security_group" "ssh" {
  name   = var.ssh_sg_name
  vpc_id = var.vpc_id

  tags = {
    Name    = var.ssh_sg_name
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "ssh_ingress_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ssh.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "ssh_ingress_icmp" {
  from_port         = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.ssh.id
  to_port           = -1
  type              = "ingress"
  cidr_blocks       = var.allowed_ip_range
}

# pub http
resource "aws_security_group" "public_http" {
  name   = var.public_http_sg_name
  vpc_id = var.vpc_id

  tags = {
    Name    = var.public_http_sg_name
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "public_http_ingress_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.public_http.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "public_http_ingress_icmp" {
  from_port         = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.public_http.id
  to_port           = -1
  type              = "ingress"
  cidr_blocks       = var.allowed_ip_range
}

# priv http
resource "aws_security_group" "private_http" {
  name   = var.private_http_sg_name
  vpc_id = var.vpc_id

  tags = {
    Name    = var.private_http_sg_name
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "private_http_ingress_http" {
  from_port                = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_http.id
  to_port                  = 8080
  type                     = "ingress"
  source_security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "private_http_ingress_icmp" {
  from_port                = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.private_http.id
  to_port                  = -1
  type                     = "ingress"
  source_security_group_id = aws_security_group.public_http.id
}

# attachments
resource "aws_network_interface_sg_attachment" "public_ssh" {
  network_interface_id = data.aws_instance.public.network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "public_http" {
  network_interface_id = data.aws_instance.public.network_interface_id
  security_group_id    = aws_security_group.public_http.id
}

resource "aws_network_interface_sg_attachment" "private_ssh" {
  network_interface_id = data.aws_instance.private.network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "private_http" {
  network_interface_id = data.aws_instance.private.network_interface_id
  security_group_id    = aws_security_group.private_http.id
}