resource "aws_iam_role" "irsa" {
  for_each = var.create_oidc_provider ? var.irsa_roles : {}
  name     = "${var.environment}-irsa-${each.key}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks[0].arn
      }
      Condition = {
        StringEquals = {
          "${var.eks_oidc_issuer_url}:sub" = "system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"
        }
      }
    }]
  })
  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "irsa" {
  for_each = var.create_oidc_provider ? {
    for item in local.irsa_policy_attachments : item.attachment_key => item
  } : {}
  role       = each.value.role_name
  policy_arn = each.value.policy_arn
}
