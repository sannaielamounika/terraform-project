variable "environment" {
  description = "Deployment environment such as dev, test, stage or prod."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for Karpenter resources."
  type        = string
  default     = "speshway"
}

variable "cluster_name" {
  description = "Name of the target EKS cluster."
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint URL."
  type        = string
  default     = null
}

variable "cluster_ca_certificate" {
  description = "Base64 encoded cluster CA cert data"
  type        = string
  default     = null
}

variable "oidc_provider_arn" {
  description = "EKS OIDC Provider ARN"
  type        = string
  default     = null
}

variable "oidc_issuer_url" {
  description = "EKS OIDC Issuer URL"
  type        = string
  default     = null
}

variable "karpenter_namespace" {
  description = "Kubernetes namespace for Karpenter."
  type        = string
  default     = "kube-system"
}

variable "namespace" {
  description = "Alias for karpenter_namespace."
  type        = string
  default     = null
}

variable "karpenter_version" {
  description = "Karpenter Helm chart version."
  type        = string
  default     = "1.6.0"
}

variable "node_role_name" {
  description = "IAM role assumed by EC2 nodes provisioned by Karpenter."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs where Karpenter can launch nodes."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to Karpenter-provisioned EC2 nodes."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional AWS resource tags."
  type        = map(string)
  default     = {}
}
