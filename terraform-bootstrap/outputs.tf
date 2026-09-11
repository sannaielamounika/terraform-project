output "s3_bucket_name" {
  description = "Name of the created S3 bucket for Terraform state."
  value       = aws_s3_bucket.state_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket."
  value       = aws_s3_bucket.state_bucket.arn
}

output "dynamodb_table_name" {
  description = "Name of the created DynamoDB table for state locking."
  value       = aws_dynamodb_table.state_locks.id
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encrypting the state bucket."
  value       = aws_kms_key.state_key.arn
}
