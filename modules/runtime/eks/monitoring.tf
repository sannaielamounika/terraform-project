resource "aws_cloudwatch_log_group" "eks" {
  count             = var.enable_cluster_logging ? 1 : 0
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 90
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-logs"
    }
  )
}
