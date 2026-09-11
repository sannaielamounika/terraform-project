variable "secret_name" {
  description = "Friendly name of the secret to manage"
  type        = string
}

variable "environment" {
  description = "Target deployment environment (e.g., dev, test, stage, prod)"
  type        = string
}

variable "description" {
  description = "Description of the secret purpose"
  type        = string
  default     = "Managed by Terraform"
}

variable "kms_key_id" {
  description = "ARN or Key ID of the AWS KMS key used to encrypt the secret"
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days AWS Secrets Manager waits before deleting a secret (0 or 7-30)"
  type        = number
  default     = 30
}

variable "secret_string_map" {
  description = "Key-value map of parameters to store in the secret as a JSON string"
  type        = map(string)
  default     = null
  sensitive   = true
}

variable "raw_secret_string" {
  description = "Raw secret string payload (used if secret_string_map is null)"
  type        = string
  default     = null
  sensitive   = true
}

variable "custom_resource_policy" {
  description = "Optional custom IAM resource policy JSON string to restrict access to this secret"
  type        = string
  default     = null
}

variable "enable_rotation" {
  description = "Controls whether automated rotation is enabled for this secret"
  type        = bool
  default     = false
}

variable "rotation_lambda_arn" {
  description = "ARN of the Lambda function configured to perform secret rotation"
  type        = string
  default     = null
}

variable "rotation_automatically_after_days" {
  description = "Specifies the number of days between automated secret rotations"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Additional tags map to merge onto Secrets Manager resources"
  type        = map(string)
  default     = {}
}
