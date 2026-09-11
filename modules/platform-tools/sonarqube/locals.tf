locals {
  tool_name   = "SonarQube"
  name_prefix = "${var.environment}-sonarqube"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Tool        = "sonarqube"
      ManagedBy   = "Terraform"
    }
  )
}
