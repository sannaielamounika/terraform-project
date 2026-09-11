variable "environment" {
  description = "Deployment environment such as dev, test, stage or prod."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for naming RDS resources."
  type        = string
  default     = "speshway"
}

variable "identifier" {
  description = "RDS instance identifier override"
  type        = string
  default     = null
}

variable "engine" {
  description = "RDS database engine."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "RDS engine version."
  type        = string
  default     = "17"
}

variable "parameter_group_family" {
  description = "RDS parameter group family matching the selected engine version."
  type        = string
  default     = "postgres17"
}

variable "database_name" {
  description = "Initial database name."
  type        = string
  default     = "speshway"
}

variable "db_name" {
  description = "Alias for database_name"
  type        = string
  default     = null
}

variable "username" {
  description = "Master database username."
  type        = string
  default     = "speshway_admin"
}

variable "db_username" {
  description = "Alias for username"
  type        = string
  default     = null
}

variable "db_password" {
  description = "Master database password when RDS-managed password is disabled."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_arn" {
  description = "Optional Secrets Manager secret containing database credentials."
  type        = string
  default     = null
}

variable "secret_username_key" {
  description = "JSON key containing the database username in Secrets Manager."
  type        = string
  default     = "username"
}

variable "secret_password_key" {
  description = "JSON key containing the database password in Secrets Manager."
  type        = string
  default     = "password"
}

variable "manage_master_user_password" {
  description = "Let Amazon RDS manage the master password in Secrets Manager."
  type        = bool
  default     = true
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the RDS DB subnet group."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Alias for private_subnet_ids"
  type        = list(string)
  default     = null
}

variable "vpc_id" {
  description = "VPC ID where the RDS security group will be created."
  type        = string
  default     = null
}

variable "application_security_group_id" {
  description = "Security group ID of the application/EKS workloads allowed to access RDS."
  type        = string
  default     = null
}

variable "port" {
  description = "Database listener port."
  type        = number
  default     = 5432
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial allocated storage in GiB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage in GiB for autoscaling."
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "RDS storage type."
  type        = string
  default     = "gp3"
}

variable "storage_encrypted" {
  description = "Enable encryption at rest for RDS."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "Customer managed KMS key ARN or ID used for RDS encryption."
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "Alias for kms_key_id"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Deploy RDS using Multi-AZ."
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether RDS receives a public IP address."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Protect the RDS instance from accidental deletion."
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply modifications immediately."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying the database."
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "Final snapshot identifier."
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred UTC backup window."
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred UTC maintenance window."
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "copy_tags_to_snapshot" {
  description = "Copy resource tags to snapshots."
  type        = bool
  default     = true
}

variable "enable_enhanced_monitoring" {
  description = "Enable RDS Enhanced Monitoring."
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Enhanced Monitoring interval in seconds. Use 0 to disable."
  type        = number
  default     = 0
}

variable "enable_performance_insights" {
  description = "Enable Amazon RDS Performance Insights."
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention period in days."
  type        = number
  default     = 7
}

variable "parameters" {
  description = "Optional database parameter group parameters."
  type        = map(string)
  default     = {}
}

variable "parameter_apply_method" {
  description = "Parameter group apply method."
  type        = string
  default     = "pending-reboot"
}

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
