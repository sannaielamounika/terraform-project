output "repository_names" {
  description = "Map of ECR repository names."
  value = {
    for k, v in aws_ecr_repository.this : k => v.name
  }
}

output "repository_arns" {
  description = "Map of ECR repository ARNs."
  value = {
    for k, v in aws_ecr_repository.this : k => v.arn
  }
}

output "repository_urls" {
  description = "Map of ECR repository URLs used by Docker and EKS."
  value = {
    for k, v in aws_ecr_repository.this : k => v.repository_url
  }
}

output "repository_url" {
  description = "Primary single repository URL"
  value       = length(values(aws_ecr_repository.this)) > 0 ? values(aws_ecr_repository.this)[0].repository_url : ""
}

output "repository_arn" {
  description = "Primary single repository ARN"
  value       = length(values(aws_ecr_repository.this)) > 0 ? values(aws_ecr_repository.this)[0].arn : ""
}

output "registry_id" {
  description = "AWS account ID containing the ECR repositories."
  value       = data.aws_caller_identity.current.account_id
}
