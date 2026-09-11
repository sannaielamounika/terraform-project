variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by EKS"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Alias for private_subnet_ids"
  type        = list(string)
  default     = null
}

variable "cluster_endpoint_private_access" {
  description = "Enable private EKS API endpoint access"
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Alias for cluster_endpoint_private_access"
  type        = bool
  default     = null
}

variable "cluster_endpoint_public_access" {
  description = "Enable public EKS API endpoint access"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Alias for cluster_endpoint_public_access"
  type        = bool
  default     = null
}

variable "cluster_public_access_cidrs" {
  description = "CIDRs allowed to access the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_cluster_encryption" {
  description = "Enable KMS encryption for Kubernetes secrets"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "Existing KMS key ARN for EKS secrets encryption"
  type        = string
  default     = null
}

variable "enable_cluster_logging" {
  description = "Enable EKS control plane logging"
  type        = bool
  default     = false
}

variable "cluster_log_types" {
  description = "EKS control plane log types"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "node_groups" {
  description = "Managed EKS node groups"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
    labels         = optional(map(string), {})
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
  }))
  default = {
    default_ng = {
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      disk_size      = 30
      labels         = {}
      taints         = []
    }
  }
}

variable "node_iam_role_arns" {
  description = "Optional existing node IAM role ARNs by node group"
  type        = map(string)
  default     = {}
}

variable "additional_cluster_security_group_ids" {
  description = "Additional security groups for EKS control plane"
  type        = list(string)
  default     = []
}

variable "create_irsa" {
  description = "Create OIDC provider and IRSA roles"
  type        = bool
  default     = true
}

variable "irsa_roles" {
  description = "IRSA roles for Kubernetes service accounts"
  type = map(object({
    namespace            = string
    service_account_name = string
    policy_arns          = list(string)
  }))
  default = {}
}

variable "enable_kms" {
  description = "Create a dedicated KMS key for EKS secrets"
  type        = bool
  default     = false
}

variable "kms_deletion_window_in_days" {
  description = "KMS deletion window"
  type        = number
  default     = 30
}

variable "kms_enable_key_rotation" {
  description = "Enable KMS automatic key rotation"
  type        = bool
  default     = true
}

variable "addons" {
  description = "EKS add-ons"
  type = map(object({
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "PRESERVE")
  }))
  default = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}
