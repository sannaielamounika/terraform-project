resource "aws_security_group" "rds" {
  count       = var.vpc_id != null ? 1 : 0
  name        = "${local.db_identifier}-sg"
  description = "Security group for ${local.db_identifier}"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow application workloads to access RDS"
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = var.application_security_group_id != null ? [var.application_security_group_id] : []
    cidr_blocks     = var.application_security_group_id == null ? ["0.0.0.0/0"] : []
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.db_identifier}-sg"
    }
  )
}
