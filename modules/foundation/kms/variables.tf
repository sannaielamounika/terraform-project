variable "environment" {
  description = "Target deployment environment (e.g., dev, test, stage, prod)"
  type        = string
}

variable "description" {
  description = "Description of the KMS key purpose"
  type        = string
  default     = "Customer Managed Key provisioned via Terraform"
}

variable "alias_name" {
  description = "KMS Key Alias name (e.g., alias/stage-app-key). Must start with alias/"
  type        = string
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted upon destruction (7 to 30 days)"
  type        = number
  default     = 30
}

variable "deletion_window_days" {
  description = "Alias for deletion_window_in_days"
  type        = number
  default     = null
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "Intended use of the key (ENCRYPT_DECRYPT or SIGN_VERIFY)"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_policy_statements" {
  description = "Custom IAM policy statements to append to the KMS Key policy"
  type        = list(any)
  default     = []
}

variable "grants" {
  description = "Map of KMS grants to create for key delegation"
  type = map(object({
    grantee_principal = string
    operations        = list(string)
  }))
  default = {}
}

variable "key_admin_arns" {
  description = "List of IAM ARNs for KMS Administrators"
  type        = list(string)
  default     = []
}

variable "key_user_arns" {
  description = "List of IAM ARNs for KMS Users"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags map to merge onto KMS resources"
  type        = map(string)
  default     = {}
}
