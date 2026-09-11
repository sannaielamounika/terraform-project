variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Target deployment environment (e.g., dev, test, stage, prod)"
  type        = string
}

variable "force_destroy" {
  description = "Controls whether to force destroy non-empty S3 bucket"
  type        = bool
  default     = false
}

variable "versioning_status" {
  description = "Versioning status (Enabled, Suspended, or Disabled)"
  type        = string
  default     = "Enabled"
}

variable "kms_master_key_arn" {
  description = "KMS Master Key ARN for SSE-KMS encryption (leave null for SSE-S3 default)"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether to block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public bucket policies"
  type        = bool
  default     = true
}

variable "target_log_bucket" {
  description = "Target S3 bucket name for storing server access logs"
  type        = string
  default     = null
}

variable "target_log_prefix" {
  description = "Log prefix for server access logs"
  type        = string
  default     = "logs/"
}

variable "lifecycle_rules" {
  description = "List of lifecycle management rules"
  type = list(object({
    id      = string
    enabled = bool
    transitions = list(object({
      days          = number
      storage_class = string
    }))
    expiration_days = optional(number)
  }))
  default = []
}

variable "replication_role_arn" {
  description = "IAM Role ARN for Cross-Region Replication"
  type        = string
  default     = null
}

variable "replication_destination_bucket_arn" {
  description = "Destination S3 Bucket ARN for Replication"
  type        = string
  default     = null
}

variable "custom_bucket_policy" {
  description = "Optional JSON string bucket policy to apply"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags map to merge onto S3 resources"
  type        = map(string)
  default     = {}
}
