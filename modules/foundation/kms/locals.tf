locals {
  effective_deletion_window = var.deletion_window_days != null ? var.deletion_window_days : var.deletion_window_in_days
  formatted_alias           = startswith(var.alias_name, "alias/") ? var.alias_name : "alias/${var.alias_name}"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "kms"
    }
  )
}
