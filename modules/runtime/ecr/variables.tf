variable "environment" {
  description = "Deployment environment such as dev, test, stage, or prod."
  type        = string
}

variable "repository_names" {
  description = "Map/set of ECR repositories to create."
  type        = set(string)
  default     = []
}

variable "repository_name" {
  description = "Single repository name convenience variable"
  type        = string
  default     = null
}

variable "image_tag_mutability" {
  description = "Whether ECR image tags can be overwritten."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable ECR image vulnerability scanning whenever an image is pushed."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "Customer managed KMS key ARN used to encrypt ECR images. If null, AES256 is used."
  type        = string
  default     = null
}

variable "enable_lifecycle_policy" {
  description = "Whether to create ECR lifecycle policies."
  type        = bool
  default     = true
}

variable "untagged_image_expiration_days" {
  description = "Number of days before untagged images are deleted."
  type        = number
  default     = 7
}

variable "keep_last_images" {
  description = "Number of version-tagged images to retain."
  type        = number
  default     = 20
}

variable "enable_repository_policy" {
  description = "Whether to create ECR repository resource policies."
  type        = bool
  default     = false
}

variable "eks_role_arns" {
  description = "IAM role ARNs allowed to pull images from ECR."
  type        = list(string)
  default     = []
}

variable "ci_cd_role_arns" {
  description = "IAM role ARNs allowed to push images to ECR."
  type        = list(string)
  default     = []
}

variable "allowed_vpc_endpoint_ids" {
  description = "Optional ECR VPC endpoint IDs allowed to access repositories."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to ECR resources."
  type        = map(string)
  default     = {}
}
