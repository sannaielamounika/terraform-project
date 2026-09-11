resource "aws_secretsmanager_secret" "this" {
  name                    = var.secret_name
  description             = var.description
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = var.recovery_window_in_days
  tags = merge(
    local.common_tags,
    {
      Name = var.secret_name
    }
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = local.secret_payload != null ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = local.secret_payload
}
