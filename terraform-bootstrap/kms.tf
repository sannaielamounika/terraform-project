## KMS Key for encrypting S3 bucket and DynamoDB table
resource "aws_kms_key" "state_key" {
  description             = "KMS Key for encrypting Terraform state storage and locks"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-kms-key"
    }
  )
}

# KMS Key Alias for readable identification in AWS Console
resource "aws_kms_alias" "state_key_alias" {
  name          = "alias/${local.name_prefix}-key"
  target_key_id = aws_kms_key.state_key.key_id
}
