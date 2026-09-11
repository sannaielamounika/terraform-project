resource "aws_secretsmanager_secret_policy" "this" {
  count      = var.custom_resource_policy != null ? 1 : 0
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = var.custom_resource_policy
}
