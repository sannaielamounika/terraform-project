variable "aws_region" {
  description = "AWS region where the environment is deployed."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "speshway"
}

variable "owner" {
  description = "Infrastructure owner."
  type        = string
  default     = "DevOps-Team"
}

variable "vpc_cidr" {
  description = "CIDR block for the environment VPC."
  type        = string
}

variable "public_subnets" {
  description = "Public subnet configuration."
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Private subnet configuration."
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "kms_keys" {
  description = "KMS keys required by the environment."
  type = map(object({
    alias_name           = string
    description          = string
    deletion_window_days = number
    enable_key_rotation  = bool
  }))
}

variable "s3_buckets" {
  description = "S3 buckets required by the environment."
  type = map(object({
    bucket_name   = string
    force_destroy = bool
  }))
}

variable "secrets" {
  description = "Secrets Manager secret definitions."
  type = map(object({
    name        = string
    description = string
  }))
}

variable "ecr_repositories" {
  description = "ECR repositories."
  type = map(object({
    name = string
  }))
}

variable "eks_cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "eks_version" {
  description = "EKS Kubernetes version."
  type        = string
}

variable "eks_endpoint_private_access" {
  description = "Enable private EKS API endpoint access."
  type        = bool
}

variable "eks_endpoint_public_access" {
  description = "Enable public EKS API endpoint access."
  type        = bool
}

variable "rds_identifier" {
  description = "RDS instance identifier."
  type        = string
}

variable "rds_engine" {
  description = "RDS engine."
  type        = string
}

variable "rds_engine_version" {
  description = "RDS engine version."
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "rds_database_name" {
  description = "Initial database name."
  type        = string
}

variable "rds_username" {
  description = "Master database username."
  type        = string
  sensitive   = true
}

variable "rds_port" {
  description = "Database port."
  type        = number
}

variable "rds_backup_retention_period" {
  description = "RDS backup retention period."
  type        = number
}

variable "rds_multi_az" {
  description = "Enable RDS Multi-AZ."
  type        = bool
}

variable "enable_karpenter" {
  description = "Enable Karpenter."
  type        = bool
  default     = true
}

variable "karpenter_namespace" {
  description = "Karpenter Kubernetes namespace."
  type        = string
  default     = "kube-system"
}

variable "karpenter_node_role_name" {
  description = "Karpenter node IAM role name."
  type        = string
  default     = "speshway-dev-karpenter-node"
}
