resource "aws_s3_bucket_replication_configuration" "this" {
  count  = var.replication_role_arn != null && var.replication_destination_bucket_arn != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  role   = var.replication_role_arn

  rule {
    id     = "CrossRegionReplicationRule"
    status = "Enabled"
    destination {
      bucket        = var.replication_destination_bucket_arn
      storage_class = "STANDARD"
    }
  }
  depends_on = [aws_s3_bucket_versioning.this]
}
