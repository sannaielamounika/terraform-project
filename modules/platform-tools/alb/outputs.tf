output "alb_dns_name" {
  value       = aws_lb.platform_alb.dns_name
  description = "The DNS name of the Application Load Balancer"
}

output "alb_arn" {
  value       = aws_lb.platform_alb.arn
  description = "The ARN of the Application Load Balancer"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb_sg.id
  description = "The Security Group ID of the Application Load Balancer"
}

output "jenkins_target_group_arn" {
  value       = aws_lb_target_group.jenkins.arn
  description = "Target Group ARN for Jenkins"
}

output "sonarqube_target_group_arn" {
  value       = aws_lb_target_group.sonarqube.arn
  description = "Target Group ARN for SonarQube"
}

output "nexus_target_group_arn" {
  value       = aws_lb_target_group.nexus.arn
  description = "Target Group ARN for Nexus"
}
