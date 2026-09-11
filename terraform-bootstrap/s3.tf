# Primary S3 Bucket for Terraform State
resource "aws_s3_bucket" "state_bucket" {
  bucket        = "${local.name_prefix}-${local.account_id}-${random_id.suffix.hex}"
  force_destroy = false # Prevent accidental deletion via Terraform destroy
  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-bucket"
    }
  )
}

# Enable Object Versioning (Critical: Allows rollback if state corrupts)
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption using our KMS Key
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.state_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Block all public access to the S3 Bucket (Security Best Practice)
resource "aws_s3_bucket_public_access_block" "state_public_block" {
  bucket                  = aws_s3_bucket.state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
