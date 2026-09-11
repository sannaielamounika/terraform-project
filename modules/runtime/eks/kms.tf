resource "aws_kms_key" "eks" {
  count                   = var.enable_kms && var.kms_key_arn == null ? 1 : 0
  description             = "KMS key for ${var.environment} EKS secrets"
  deletion_window_in_days = var.kms_deletion_window_in_days
  enable_key_rotation     = var.kms_enable_key_rotation

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableRootPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-kms"
    }
  )
}

resource "aws_kms_alias" "eks" {
  count         = var.enable_kms && var.kms_key_arn == null ? 1 : 0
  name          = "alias/${local.name_prefix}-eks"
  target_key_id = aws_kms_key.eks[0].key_id
}
