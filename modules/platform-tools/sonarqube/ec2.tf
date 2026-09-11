resource "random_password" "db_password" {
  count   = (var.db_password != null && var.db_password != "") ? 0 : 1
  length  = 16
  special = false
}

locals {
  effective_db_password = (var.db_password != null && var.db_password != "") ? var.db_password : random_password.db_password[0].result
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.environment}/sonarqube/db_password"
  description = "Auto-generated PostgreSQL database password for SonarQube"
  type        = "SecureString"
  value       = local.effective_db_password

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-password"
  })
}

resource "aws_instance" "this" {
  ami                    = (var.ami_id != null && var.ami_id != "") ? var.ami_id : data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = var.key_name != "" ? var.key_name : null
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  iam_instance_profile   = aws_iam_instance_profile.this.name

  user_data = templatefile("${path.module}/user_data.sh", {
    data_mount_path      = var.data_mount_path
    web_port             = var.web_port
    db_username          = var.db_username
    db_password          = local.effective_db_password
    db_name              = var.db_name
    postgres_version     = var.postgres_version
    sonarqube_version    = var.sonarqube_version
    sysctl_max_map_count = var.sysctl_max_map_count
    sysctl_fs_file_max   = var.sysctl_fs_file_max
    db_init_sleep        = var.db_init_sleep
  })

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = true
    delete_on_termination = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-server"
  })
}

resource "aws_eip" "this" {
  count    = var.enable_eip ? 1 : 0
  instance = aws_instance.this.id
  domain   = "vpc"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-eip"
  })
}
