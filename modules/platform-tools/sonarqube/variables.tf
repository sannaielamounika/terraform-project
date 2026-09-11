variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Target Subnet ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance size"
}

variable "root_volume_size" {
  type        = number
  description = "Root disk volume size in GB"
}

variable "root_volume_type" {
  type        = string
  description = "Root disk volume type"
  default     = "gp3"
}

variable "data_volume_size" {
  type        = number
  description = "Persistent data volume size in GB"
}

variable "data_volume_type" {
  type        = string
  description = "Persistent data volume type"
  default     = "gp3"
}

variable "data_device_name" {
  type        = string
  description = "Block device name for data EBS volume attachment"
}

variable "data_mount_path" {
  type        = string
  description = "Mount directory for SonarQube data"
}

variable "web_port" {
  type        = number
  description = "SonarQube Web UI HTTP port"
}

variable "db_username" {
  type        = string
  description = "PostgreSQL DB Username"
}

variable "db_password" {
  type        = string
  description = "PostgreSQL DB Password (optional, auto-generated if empty)"
  sensitive   = true
  default     = ""
}

variable "db_name" {
  type        = string
  description = "PostgreSQL Database Name"
}

variable "sonarqube_version" {
  type        = string
  description = "SonarQube container image version tag"
}

variable "postgres_version" {
  type        = string
  description = "PostgreSQL container image version tag"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Allowed CIDRs for ingress"
}

variable "ami_id" {
  type        = string
  description = "AMI ID (defaults to Amazon Linux 2023 if empty)"
  default     = null
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for EBS encryption"
  default     = null
}

variable "enable_eip" {
  type        = bool
  description = "Allocate Elastic IP"
  default     = true
}

variable "key_name" {
  type        = string
  description = "EC2 Key Pair Name"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "monitoring" {
  type = object({
    enabled = bool
    cpu = object({
      enabled            = bool
      threshold          = number
      period             = number
      evaluation_periods = number
      statistic          = string
    })
    status_check = object({
      enabled            = bool
      threshold          = number
      period             = number
      evaluation_periods = number
      statistic          = string
    })
  })
  description = "CloudWatch monitoring configuration"
}

variable "ami_name_filter" {
  type        = string
  description = "AMI name filter for Amazon Linux"
}

variable "ssm_policy_arn" {
  type        = string
  description = "IAM Policy ARN for Systems Manager SSM"
}

variable "sysctl_max_map_count" {
  type        = number
  description = "Linux kernel sysctl vm.max_map_count limit"
}

variable "sysctl_fs_file_max" {
  type        = number
  description = "Linux kernel sysctl fs.file-max limit"
}

variable "db_init_sleep" {
  type        = number
  description = "Sleep duration in seconds for PostgreSQL initialization"
}
