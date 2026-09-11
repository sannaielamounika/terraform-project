locals {
  name_prefix         = "${var.environment}-${var.cluster_name}-karpenter"
  effective_namespace = var.namespace != null ? var.namespace : var.karpenter_namespace
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "karpenter"
      Cluster     = var.cluster_name
    }
  )
}
