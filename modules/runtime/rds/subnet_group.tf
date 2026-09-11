resource "aws_db_subnet_group" "this" {
  name        = "${local.db_identifier}-subnet-group"
  description = "Private subnet group for ${local.db_identifier}"
  subnet_ids  = local.effective_subnets
  tags = merge(
    local.common_tags,
    {
      Name = "${local.db_identifier}-subnet-group"
    }
  )
}
