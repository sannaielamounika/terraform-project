resource "aws_security_group" "this" {
  name        = "${local.name_prefix}-sg"
  description = "Security group for Nexus Server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Nexus Web UI & Repository API"
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Nexus Private Docker Registry Connector"
    from_port   = var.docker_registry_port
    to_port     = var.docker_registry_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })
}
