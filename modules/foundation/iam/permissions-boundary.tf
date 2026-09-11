data "aws_iam_policy_document" "boundary_doc" {
  count = var.create_permissions_boundary ? 1 : 0
  statement {
    sid    = "AllowedServicesBoundary"
    effect = "Allow"
    actions = [
      "s3:*",
      "ec2:*",
      "rds:*",
      "kms:*",
      "secretsmanager:*",
      "logs:*",
      "cloudwatch:*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "DenyBoundaryRemoval"
    effect = "Deny"
    actions = [
      "iam:DeletePermissionsBoundary",
      "iam:DeleteRolePermissionsBoundary"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "permissions_boundary" {
  count       = var.create_permissions_boundary ? 1 : 0
  name        = "${var.environment}-permissions-boundary"
  description = "Global permissions boundary guardrail for ${var.environment}"
  policy      = data.aws_iam_policy_document.boundary_doc[0].json
  tags        = local.common_tags
}
