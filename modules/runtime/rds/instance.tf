resource "aws_db_instance" "this" {
  identifier                  = local.db_identifier
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  allocated_storage           = var.allocated_storage
  max_allocated_storage       = var.max_allocated_storage
  storage_type                = var.storage_type
  db_name                     = local.effective_db_name
  username                    = local.effective_username
  manage_master_user_password = var.manage_master_user_password
  password                    = var.manage_master_user_password ? null : var.db_password
  port                        = var.port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_id != null ? [aws_security_group.rds[0].id] : []
  parameter_group_name   = aws_db_parameter_group.this.name

  multi_az              = var.multi_az
  publicly_accessible   = var.publicly_accessible
  storage_encrypted     = var.storage_encrypted
  kms_key_id            = local.effective_kms_key
  deletion_protection   = var.deletion_protection
  apply_immediately     = var.apply_immediately
  skip_final_snapshot   = var.skip_final_snapshot
  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  monitoring_interval = var.enable_enhanced_monitoring ? var.monitoring_interval : 0
  monitoring_role_arn = var.enable_enhanced_monitoring ? aws_iam_role.rds_monitoring[0].arn : null

  auto_minor_version_upgrade = true
  iam_database_authentication_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = local.db_identifier
    }
  )
}
