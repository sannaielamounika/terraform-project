resource "aws_s3_bucket_logging" "this" {
  count         = var.target_log_bucket != null ? 1 : 0
  bucket        = aws_s3_bucket.this.id
  target_bucket = var.target_log_bucket
  target_prefix = var.target_log_prefix
}
