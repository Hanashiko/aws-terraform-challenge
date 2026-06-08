variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_id" {
  description = "Unique project identifier used for resource naming and tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "public_instance_id" {
  description = "ID of the existing public EC2 instance"
  type        = string
}

variable "private_instance_id" {
  description = "ID of the existing private EC2 instance"
  type        = string
}

variable "ssh_sg_name" {
  description = "Name of the SSH security group"
  type        = string
}

variable "public_http_sg_name" {
  description = "Name of the public HTTP security group"
  type        = string
}

variable "private_http_sg_name" {
  description = "Name of the private HTTP security group"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of IP ranges allowed to access the infrastructure"
  type        = list(string)
}