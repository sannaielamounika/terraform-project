resource "aws_ecr_repository" "this" {
  for_each             = local.effective_repos
  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = local.encryption_type
    kms_key         = var.kms_key_arn
  }

  force_delete = true
  tags = merge(
    local.common_tags,
    {
      Name = each.value
    }
  )
}
