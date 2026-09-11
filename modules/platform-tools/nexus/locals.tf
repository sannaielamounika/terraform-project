locals {
  tool_name   = "Nexus"
  name_prefix = "${var.environment}-nexus"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Tool        = "nexus"
      ManagedBy   = "Terraform"
    }
  )
}
