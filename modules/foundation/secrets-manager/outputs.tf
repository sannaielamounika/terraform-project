output "secret_arn" {
  description = "The Amazon Resource Name (ARN) of the secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_id" {
  description = "The unique identifier of the secret"
  value       = aws_secretsmanager_secret.this.id
}

output "secret_version_id" {
  description = "The unique version identifier for the secret payload"
  value       = length(aws_secretsmanager_secret_version.this) > 0 ? aws_secretsmanager_secret_version.this[0].version_id : null
}
