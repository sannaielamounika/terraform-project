resource "aws_secretsmanager_secret_rotation" "this" {
  count               = var.enable_rotation && var.rotation_lambda_arn != null ? 1 : 0
  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = var.rotation_lambda_arn
  rotation_rules {
    automatically_after_days = var.rotation_automatically_after_days
  }
}
