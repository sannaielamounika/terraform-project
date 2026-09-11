resource "aws_kms_alias" "this" {
  name          = local.formatted_alias
  target_key_id = aws_kms_key.this.key_id
}
