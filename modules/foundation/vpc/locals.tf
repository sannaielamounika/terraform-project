locals {
  name_prefix = "${var.environment}-${var.name_prefix}"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "modules/foundation/vpc"
      Layer       = "Networking"
    }
  )
}
