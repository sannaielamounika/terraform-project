variable "aws_region" {
  description = "AWS Region for Production Deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Target environment name"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for Production VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnet configurations"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnet configurations"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "s3_buckets" {
  description = "Map of S3 buckets to provision"
  type = map(object({
    bucket_name       = string
    versioning_status = string
    force_destroy     = bool
  }))
}

variable "prod_secrets" {
  description = "Map of production secrets"
  type = map(object({
    name        = string
    description = string
    payload     = map(string)
  }))
}

variable "kms_keys" {
  description = "Map of KMS master key configurations"
  type = map(object({
    alias_name              = string
    description             = string
    deletion_window_in_days = number
    enable_key_rotation     = bool
  }))
}
