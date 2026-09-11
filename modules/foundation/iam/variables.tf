variable "environment" {
  description = "Target deployment environment (e.g., dev, test, stage, prod)"
  type        = string
}

variable "create_permissions_boundary" {
  description = "Controls whether to create and apply a baseline IAM permissions boundary guardrail"
  type        = bool
  default     = false
}

variable "custom_policies" {
  description = "Map of custom IAM managed policies to create"
  type = map(object({
    description = string
    policy_json = string
  }))
  default = {}
}

variable "roles" {
  description = "Map of IAM roles to provision along with trust relationships and attached policy ARNs"
  type = map(object({
    assume_role_service = string
    policy_arns         = list(string)
  }))
  default = {}
}

variable "instance_profiles" {
  description = "Map of EC2 Instance Profiles linked to IAM roles"
  type = map(object({
    role_name = string
  }))
  default = {}
}

variable "create_oidc_provider" {
  description = "Controls whether to create the OIDC Provider for EKS IRSA"
  type        = bool
  default     = false
}

variable "eks_oidc_issuer_url" {
  description = "The EKS cluster OIDC issuer URL (excluding https://)"
  type        = string
  default     = ""
}

variable "irsa_roles" {
  description = "Map of IRSA role configurations for Kubernetes workloads"
  type = map(object({
    namespace            = string
    service_account_name = string
    policy_arns          = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "Additional tags map to merge onto IAM resources"
  type        = map(string)
  default     = {}
}
