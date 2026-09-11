locals {
  sse_algorithm = var.kms_master_key_arn != null ? "aws:kms" : "AES256"
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "s3"
    }
  )
}
