resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags = merge(
    local.common_tags,
    {
      Name = var.bucket_name
    }
  )
}
