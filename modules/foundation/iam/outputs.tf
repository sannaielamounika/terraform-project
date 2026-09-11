output "role_arns" {
  description = "Map of generated standard IAM role ARNs"
  value       = { for k, v in aws_iam_role.this : k => v.arn }
}

output "custom_policy_arns" {
  description = "Map of created custom policy ARNs"
  value       = { for k, v in aws_iam_policy.custom : k => v.arn }
}

output "instance_profile_names" {
  description = "Map of created EC2 instance profile names"
  value       = { for k, v in aws_iam_instance_profile.this : k => v.name }
}

output "irsa_role_arns" {
  description = "Map of created EKS IRSA role ARNs"
  value       = { for k, v in aws_iam_role.irsa : k => v.arn }
}

output "permissions_boundary_arn" {
  description = "ARN of the created permissions boundary policy"
  value       = local.permissions_boundary_arn
}
