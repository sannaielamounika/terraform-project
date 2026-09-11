resource "aws_db_parameter_group" "this" {
  name        = "${local.db_identifier}-params"
  family      = var.parameter_group_family
  description = "Parameter group for ${local.db_identifier}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = var.parameter_apply_method
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.db_identifier}-params"
    }
  )
}
