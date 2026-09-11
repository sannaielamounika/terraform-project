locals {
  effective_subnets  = length(var.private_subnet_ids) > 0 ? var.private_subnet_ids : (var.subnet_ids != null ? var.subnet_ids : [])
  effective_kms_key  = var.kms_key_id != null ? var.kms_key_id : var.kms_key_arn
  effective_db_name  = var.database_name != null ? var.database_name : (var.db_name != null ? var.db_name : "speshway")
  effective_username = var.username != null ? var.username : (var.db_username != null ? var.db_username : "speshway_admin")
  db_identifier      = var.identifier != null ? var.identifier : lower("${var.name_prefix}-${var.environment}-rds")

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "runtime-rds"
      Layer       = "Runtime"
    }
  )
}
