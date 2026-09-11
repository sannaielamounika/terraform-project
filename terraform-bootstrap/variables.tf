variable "aws_region" {
  type        = string
  description = "The AWS Region where resources will be deployed."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name (e.g., prod, staging, dev)."
  default     = "prod"
}

variable "project_name" {
  type        = string
  description = "Project or application name used as a naming prefix."
  default     = "tf-state"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to all resources."
  default = {
    ManagedBy   = "Terraform"
    Environment = "prod"
    Purpose     = "Terraform-State-Bootstrap"
  }
}

variable "noncurrent_version_expiration_days" {
  type        = number
  description = "Number of days after which older versions of state files expire in S3."
  default     = 90
}
