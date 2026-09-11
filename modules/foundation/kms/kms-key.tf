resource "aws_kms_key" "this" {
  description             = "${var.description} (${var.environment})"
  deletion_window_in_days = local.effective_deletion_window
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage
  policy                  = data.aws_iam_policy_document.kms_policy.json
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-kms-key"
    }
  )
}
