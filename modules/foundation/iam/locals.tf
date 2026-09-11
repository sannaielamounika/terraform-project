locals {
  name_prefix              = "${var.environment}-iam"
  permissions_boundary_arn = var.create_permissions_boundary ? aws_iam_policy.permissions_boundary[0].arn : null
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "iam"
    }
  )

  role_policy_attachments = flatten([
    for role_key, role_val in var.roles : [
      for policy_arn in role_val.policy_arns : {
        attachment_key = "${role_key}-${md5(policy_arn)}"
        role_name      = aws_iam_role.this[role_key].name
        policy_arn     = policy_arn
      }
    ]
  ])

  irsa_policy_attachments = flatten([
    for irsa_key, irsa_val in var.irsa_roles : [
      for policy_arn in irsa_val.policy_arns : {
        attachment_key = "${irsa_key}-${md5(policy_arn)}"
        role_name      = aws_iam_role.irsa[irsa_key].name
        policy_arn     = policy_arn
      }
    ]
  ])
}
