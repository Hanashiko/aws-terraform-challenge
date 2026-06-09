variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the VPC to discover"
  type        = string
}

variable "public_subnet_name" {
  description = "Name tag of the public subnet to discover"
  type        = string
}

variable "security_group_name" {
  description = "Name tag of the security group to discover"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance to create"
  type        = string
}
