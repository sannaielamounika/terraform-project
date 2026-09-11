resource "aws_lb" "platform_alb" {
  name               = "${var.environment}-platform-alb"
  internal           = var.internal_alb
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb"
  })
}
