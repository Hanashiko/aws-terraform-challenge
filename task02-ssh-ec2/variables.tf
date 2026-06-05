variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_id" {
  description = "Unique project identifier used for resource naming and tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name of the existing VPC to reference via data source"
  type        = string
}

variable "security_group_name" {
  description = "Name of the existing security group to reference via data source"
  type        = string
}

variable "keypair_name" {
  description = "Name of the AWS key pair resource"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 isntance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key"
  type        = string
}
