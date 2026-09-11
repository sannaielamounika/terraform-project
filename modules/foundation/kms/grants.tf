resource "aws_kms_grant" "this" {
  for_each          = var.grants
  name              = "${var.environment}-${each.key}-grant"
  key_id            = aws_kms_key.this.key_id
  grantee_principal = each.value.grantee_principal
  operations        = each.value.operations
}
