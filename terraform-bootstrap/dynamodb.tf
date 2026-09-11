resource "aws_dynamodb_table" "state_locks" {
  name         = "${local.name_prefix}-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.state_key.arn
  }
  point_in_time_recovery {
    enabled = true
  }
  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-locks"
    }
  )
}
