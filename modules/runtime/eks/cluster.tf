resource "aws_eks_cluster" "this" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.cluster.arn
  version                   = var.cluster_version
  enabled_cluster_log_types = var.enable_cluster_logging ? var.cluster_log_types : []

  vpc_config {
    subnet_ids              = local.effective_subnets
    endpoint_private_access = local.endpoint_private
    endpoint_public_access  = local.endpoint_public
    public_access_cidrs     = var.cluster_public_access_cidrs
    security_group_ids = concat(
      [aws_security_group.cluster.id],
      var.additional_cluster_security_group_ids
    )
  }

  dynamic "encryption_config" {
    for_each = var.enable_cluster_encryption && (var.kms_key_arn != null || var.enable_kms) ? [1] : []
    content {
      provider {
        key_arn = var.kms_key_arn != null ? var.kms_key_arn : aws_kms_key.eks[0].arn
      }
      resources = ["secrets"]
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
  tags = local.common_tags
}
