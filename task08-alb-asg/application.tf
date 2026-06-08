data "aws_ami" "amazon_linux" {
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

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name = "map-public-ip-on-launch"
    values = ["true"]
  }
}

data "aws_security_group" "ec2_sg" {
  filter {
    name   = "tag:Name"
    values = [var.ec2_sg_name]
  }
}

data "aws_security_group" "http_sg" {
  filter {
    name   = "tag:Name"
    values = [var.http_sg_name]
  }
}

data "aws_security_group" "lb_sg" {
  filter {
    name   = "tag:Name"
    values = [var.lb_sg_name]
  }
}

locals {
  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd jq

systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

echo "<html><body><h1>This message was generated on instance $INSTANCE_IP with the following IP: $PRIVATE_IP</h1></body></html>" \
> /var/www/html/index.html
EOF
}

resource "aws_launch_template" "main" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(local.user_data)

  network_interfaces {
    security_groups       = [data.aws_security_group.ec2_sg.id, data.aws_security_group.http_sg.id]
    delete_on_termination = true
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_autoscaling_group" "main" {
  name                = var.asg_name
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = data.aws_subnets.public.ids

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }
}

resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_sg.id]
  subnets            = data.aws_subnets.public.ids
  enable_cross_zone_load_balancing = true

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.project_id}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
  load_balancing_algorithm_type = "round_robin"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  lb_target_group_arn    = aws_lb_target_group.main.arn
}