locals {
  effective_repos = length(var.repository_names) > 0 ? var.repository_names : (var.repository_name != null ? toset([var.repository_name]) : toset([]))
  name_prefix     = "${var.environment}-ecr"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "ecr"
    }
  )
  encryption_type = var.kms_key_arn != null ? "KMS" : "AES256"
}
