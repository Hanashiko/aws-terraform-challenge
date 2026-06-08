variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for resource naming and tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name of the existing VPC"
  type        = string
}

variable "launch_template_name" {
  description = "Name of the Launch Template"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "ec2_sg_name" {
  description = "Name of the EC2 SSH security group"
  type        = string
}

variable "http_sg_name" {
  description = "Name of the EC2 HTTP security group"
  type        = string
}

variable "lb_sg_name" {
  description = "Name of the Load Balancer security group"
  type        = string
}

variable "iam_instance_profile" {
  description = "Name of the IAM instance profile for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}