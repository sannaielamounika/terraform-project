resource "aws_iam_policy" "custom" {
  for_each    = var.custom_policies
  name        = "${var.environment}-${each.key}-policy"
  description = each.value.description
  policy      = each.value.policy_json
  tags        = local.common_tags
}
