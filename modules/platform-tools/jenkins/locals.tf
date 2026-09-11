locals {
  tool_name   = "Jenkins"
  name_prefix = "${var.environment}-jenkins"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Tool        = "jenkins"
      ManagedBy   = "Terraform"
    }
  )
}
