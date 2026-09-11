output "environment" {
  description = "Environment name."
  value       = var.environment
}

output "vpc_id" {
  description = "Environment VPC ID."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.network.private_subnet_ids
}

output "kms_key_arns" {
  description = "KMS key ARNs."
  value = {
    for key, value in module.kms : key => value.key_arn
  }
}

output "ecr_repository_urls" {
  description = "ECR repository URLs."
  value = {
    for key, value in module.ecr : key => value.repository_url
  }
}

output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS API endpoint."
  value       = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  description = "RDS endpoint."
  value       = module.rds.endpoint
}

output "secret_arns" {
  description = "Secrets Manager secret ARNs."
  value = {
    for key, value in module.secrets_manager : key => value.secret_arn
  }
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
