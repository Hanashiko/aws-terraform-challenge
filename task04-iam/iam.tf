resource "aws_iam_group" "main" {
  name = var.iam_group_name

}

resource "aws_iam_policy" "main" {
  name = var.iam_policy_name

  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.bucket_name
  })

  tags = {
    Project = var.project_id
  }
}

resource "aws_iam_role" "main" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = var.project_id
  }
}

resource "aws_iam_role_policy_attachment" "main" {
  policy_arn = aws_iam_policy.main.id
  role       = aws_iam_role.main.name
}

resource "aws_iam_instance_profile" "main" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.main.name

  tags = {
    Project = var.project_id
  }
}