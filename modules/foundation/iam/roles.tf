data "aws_iam_policy_document" "assume_role_policy" {
  for_each = var.roles
  statement {
    sid    = "AllowServiceAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["${each.value.assume_role_service}.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  for_each             = var.roles
  name                 = "${var.environment}-${each.key}-role"
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy[each.key].json
  permissions_boundary = local.permissions_boundary_arn
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-${each.key}-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for item in local.role_policy_attachments : item.attachment_key => item
  }
  role       = each.value.role_name
  policy_arn = each.value.policy_arn
}
