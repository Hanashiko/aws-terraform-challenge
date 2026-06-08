output "iam_group_name" {
  description = "Name of the created IAM group"
  value       = aws_iam_group.main.name
}

output "iam_policy_arn" {
  value       = aws_iam_policy.main.arn
  description = "ARN of the created IAM policy"
}

output "iam_role_arn" {
  value       = aws_iam_role.main.arn
  description = "ARN of the created IAM role"
}

output "iam_instance_profile_name" {
  value       = aws_iam_instance_profile.main.name
  description = "Name of the created IAM instance profile"
}