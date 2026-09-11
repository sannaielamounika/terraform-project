# Target Group for Jenkins
resource "aws_lb_target_group" "jenkins" {
  name        = "${var.environment}-jenkins-tg"
  port        = var.jenkins_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.jenkins_health_check_path
    protocol            = var.target_group_protocol
    matcher             = var.jenkins_health_check_matcher
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-jenkins-tg"
  })
}

resource "aws_lb_target_group_attachment" "jenkins" {
  target_group_arn = aws_lb_target_group.jenkins.arn
  target_id        = var.jenkins_instance_id
  port             = var.jenkins_port
}

# Target Group for SonarQube
resource "aws_lb_target_group" "sonarqube" {
  name        = "${var.environment}-sonarqube-tg"
  port        = var.sonarqube_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.sonarqube_health_check_path
    protocol            = var.target_group_protocol
    matcher             = var.sonarqube_health_check_matcher
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sonarqube-tg"
  })
}

resource "aws_lb_target_group_attachment" "sonarqube" {
  target_group_arn = aws_lb_target_group.sonarqube.arn
  target_id        = var.sonarqube_instance_id
  port             = var.sonarqube_port
}

# Target Group for Nexus Web UI
resource "aws_lb_target_group" "nexus" {
  name        = "${var.environment}-nexus-tg"
  port        = var.nexus_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.nexus_health_check_path
    protocol            = var.target_group_protocol
    matcher             = var.nexus_health_check_matcher
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nexus-tg"
  })
}

resource "aws_lb_target_group_attachment" "nexus" {
  target_group_arn = aws_lb_target_group.nexus.arn
  target_id        = var.nexus_instance_id
  port             = var.nexus_port
}

# Target Group for Nexus Docker Registry
resource "aws_lb_target_group" "nexus_docker" {
  name        = "${var.environment}-nexus-docker-tg"
  port        = var.nexus_docker_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.nexus_docker_health_check_path
    protocol            = var.target_group_protocol
    matcher             = var.nexus_docker_health_check_matcher
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nexus-docker-tg"
  })
}

resource "aws_lb_target_group_attachment" "nexus_docker" {
  target_group_arn = aws_lb_target_group.nexus_docker.arn
  target_id        = var.nexus_instance_id
  port             = var.nexus_docker_port
}
