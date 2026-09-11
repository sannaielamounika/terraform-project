output "vpc_id" {
  description = "The Production VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Map of generated public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of generated private subnet IDs"
  value       = module.network.private_subnet_ids
}

output "kms_key_arn" {
  description = "Production KMS Master Key ARN"
  value       = module.kms["prod_master"].key_arn
}

output "s3_bucket_arns" {
  description = "Map of created production S3 bucket ARNs"
  value       = { for k, v in module.s3_buckets : k => v.bucket_arn }
}

output "secret_arns" {
  description = "Map of created production Secret ARNs"
  value       = { for k, v in module.secrets_manager : k => v.secret_arn }
}

output "platform_alb_dns_name" {
  description = "DNS Name of the Platform Tools Internal ALB."
  value       = try(module.platform_alb.alb_dns_name, "")
}

output "jenkins_private_ip" {
  description = "Private IP of Jenkins Server."
  value       = try(module.jenkins.private_ip, "")
}

output "sonarqube_private_ip" {
  description = "Private IP of SonarQube Server."
  value       = try(module.sonarqube.private_ip, "")
}

output "nexus_private_ip" {
  description = "Private IP of Nexus Server."
  value       = try(module.nexus.private_ip, "")
}
