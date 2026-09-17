resource "aws_iam_role" "this" {
  name = "${local.name_prefix}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy" "eks_access" {
  name = "jenkins-eks-access"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect  = "Allow"
        Action  = ["eks:*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role     = aws_iam_role.this.name
  policy_arn = var.ssm_policy_arn
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role     = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "eks" {
  role     = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.name_prefix}-profile"
  role = aws_iam_role.this.name
}
