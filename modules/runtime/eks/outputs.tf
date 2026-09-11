output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.this.id
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "EKS Kubernetes API endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "EKS Kubernetes version"
  value       = aws_eks_cluster.this.version
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = aws_security_group.cluster.id
}

output "node_security_group_id" {
  description = "EKS node security group ID"
  value       = aws_security_group.node.id
}

output "node_group_arns" {
  description = "EKS managed node group ARNs"
  value = {
    for k, v in aws_eks_node_group.this : k => v.arn
  }
}

output "node_group_names" {
  description = "EKS managed node group names"
  value = {
    for k, v in aws_eks_node_group.this : k => v.node_group_name
  }
}

output "oidc_provider_arn" {
  description = "EKS OIDC provider ARN"
  value       = var.create_irsa ? aws_iam_openid_connect_provider.eks[0].arn : null
}

output "oidc_issuer_url" {
  description = "EKS OIDC issuer URL"
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "cluster_certificate_authority" {
  description = "EKS cluster CA certificate base64"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "kms_key_arn" {
  description = "KMS key ARN used for EKS secrets"
  value       = var.kms_key_arn != null ? var.kms_key_arn : (var.enable_kms ? aws_kms_key.eks[0].arn : null)
}
