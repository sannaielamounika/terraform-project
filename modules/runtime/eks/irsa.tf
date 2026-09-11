data "aws_iam_policy_document" "irsa_assume_role" {
  for_each = var.create_irsa ? var.irsa_roles : {}
  statement {
    sid    = "IRSAAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks[0].arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"]
    }
  }
}

resource "aws_iam_role" "irsa" {
  for_each           = var.create_irsa ? var.irsa_roles : {}
  name               = "${local.name_prefix}-irsa-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.irsa_assume_role[each.key].json
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-irsa-${each.key}"
    }
  )
}
