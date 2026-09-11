locals {
  name_prefix = "${var.environment}-platform"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Module      = "platform-alb"
      ManagedBy   = "Terraform"
    }
  )
}
