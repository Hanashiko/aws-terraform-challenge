variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_id" {
  description = "Unique project identifier used for resource naming and tagging"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}