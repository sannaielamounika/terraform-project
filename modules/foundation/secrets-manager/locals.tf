locals {
  secret_payload = var.secret_string_map != null ? jsonencode(var.secret_string_map) : var.raw_secret_string
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "secrets-manager"
    }
  )
}
