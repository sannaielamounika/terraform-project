output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.gateway.arn
}

output "alb_dns_name" {
  description = "DNS Name of the Application Load Balancer"
  value       = aws_lb.gateway.dns_name
}

output "alb_zone_id" {
  description = "Route 53 Zone ID of the Application Load Balancer"
  value       = aws_lb.gateway.zone_id
}

output "target_group_arn" {
  description = "ARN of the Gateway Target Group"
  value       = aws_lb_target_group.gateway.arn
}

output "alb_security_group_id" {
  description = "Security Group ID of the Application Load Balancer"
  value       = aws_security_group.alb.id
}
