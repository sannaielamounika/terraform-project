resource "aws_iam_instance_profile" "this" {
  for_each = var.instance_profiles
  name     = "${var.environment}-${each.key}-profile"
  role     = lookup(aws_iam_role.this, each.value.role_name, null) != null ? aws_iam_role.this[each.value.role_name].name : each.value.role_name
  tags     = local.common_tags
}
