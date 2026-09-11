# Default HTTP Listener
resource "aws_lb_listener" "http_80" {
  load_balancer_arn = aws_lb.platform_alb.arn
  port              = var.default_listener_port
  protocol          = var.target_group_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }
}

# Dedicated Listener for Jenkins
resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.platform_alb.arn
  port              = var.jenkins_port
  protocol          = var.target_group_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }
}

# Dedicated Listener for SonarQube
resource "aws_lb_listener" "sonarqube" {
  load_balancer_arn = aws_lb.platform_alb.arn
  port              = var.sonarqube_port
  protocol          = var.target_group_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sonarqube.arn
  }
}

# Dedicated Listener for Nexus
resource "aws_lb_listener" "nexus" {
  load_balancer_arn = aws_lb.platform_alb.arn
  port              = var.nexus_port
  protocol          = var.target_group_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nexus.arn
  }
}

# Dedicated Listener for Nexus Docker Registry
resource "aws_lb_listener" "nexus_docker" {
  load_balancer_arn = aws_lb.platform_alb.arn
  port              = var.nexus_docker_port
  protocol          = var.target_group_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nexus_docker.arn
  }
}
