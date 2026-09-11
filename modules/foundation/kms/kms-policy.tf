data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid    = "EnableRootPermissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = length(var.key_admin_arns) > 0 ? [1] : []
    content {
      sid    = "KeyAdministrators"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.key_admin_arns
      }
      actions = [
        "kms:Create*", "kms:Describe*", "kms:Enable*", "kms:Disable*", "kms:Update*",
        "kms:Put*", "kms:Get*", "kms:List*", "kms:Delete*", "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion", "kms:TagResource", "kms:UntagResource"
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = length(var.key_user_arns) > 0 ? [1] : []
    content {
      sid    = "KeyUsers"
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = var.key_user_arns
      }
      actions = [
        "kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey"
      ]
      resources = ["*"]
    }
  }
}
