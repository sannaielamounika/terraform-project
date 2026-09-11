locals {
  effective_subnets = length(var.private_subnet_ids) > 0 ? var.private_subnet_ids : (var.subnet_ids != null ? var.subnet_ids : [])
  endpoint_private  = var.endpoint_private_access != null ? var.endpoint_private_access : var.cluster_endpoint_private_access
  endpoint_public   = var.endpoint_public_access != null ? var.endpoint_public_access : var.cluster_endpoint_public_access

  name_prefix = "${var.environment}-${var.cluster_name}"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "eks"
      Kubernetes  = var.cluster_name
    }
  )
  cluster_security_group_name = "${local.name_prefix}-cluster-sg"
  node_security_group_name    = "${local.name_prefix}-node-sg"
}
