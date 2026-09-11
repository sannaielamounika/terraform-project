resource "aws_s3_bucket_lifecycle_configuration" "state_lifecycle" {
  depends_on = [aws_s3_bucket_versioning.state_versioning]
  bucket     = aws_s3_bucket.state_bucket.id
  rule {
    id     = "expire-old-state-versions"
    status = "Enabled"
    filter {}
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }
    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration_days
    }
  }
}
