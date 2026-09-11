# Platform Tools Instantiation (Frontend / Environment Configuration)

module "jenkins" {
  source              = "../../modules/platform-tools/jenkins"
  environment         = var.environment
  vpc_id              = module.network.vpc_id
  subnet_id           = values(module.network.public_subnet_ids)[0]
  instance_type       = var.jenkins_instance_type
  root_volume_size    = var.jenkins_root_volume_size
  data_volume_size    = var.jenkins_data_volume_size
  data_device_name    = var.data_device_name
  data_mount_path     = var.jenkins_data_mount_path
  web_port            = var.jenkins_port
  jnlp_port           = var.jenkins_jnlp_port
  jenkins_version     = var.jenkins_version
  key_name            = var.key_name
  allowed_cidr_blocks = var.platform_tools_allowed_cidrs
  monitoring          = var.platform_monitoring
  ami_name_filter     = var.ami_name_filter
  ssm_policy_arn      = var.ssm_policy_arn
}

module "sonarqube" {
  source               = "../../modules/platform-tools/sonarqube"
  environment          = var.environment
  vpc_id               = module.network.vpc_id
  subnet_id            = values(module.network.public_subnet_ids)[0]
  instance_type        = var.sonarqube_instance_type
  root_volume_size     = var.sonarqube_root_volume_size
  data_volume_size     = var.sonarqube_data_volume_size
  data_device_name     = var.data_device_name
  data_mount_path      = var.sonarqube_data_mount_path
  web_port             = var.sonarqube_port
  db_username          = var.sonarqube_db_username
  db_password          = var.sonarqube_db_password
  db_name              = var.sonarqube_db_name
  sonarqube_version    = var.sonarqube_version
  postgres_version     = var.postgres_version
  sysctl_max_map_count = var.sysctl_max_map_count
  sysctl_fs_file_max   = var.sysctl_fs_file_max
  db_init_sleep        = var.db_init_sleep
  key_name             = var.key_name
  allowed_cidr_blocks  = var.platform_tools_allowed_cidrs
  monitoring           = var.platform_monitoring
  ami_name_filter      = var.ami_name_filter
  ssm_policy_arn       = var.ssm_policy_arn
}

module "nexus" {
  source               = "../../modules/platform-tools/nexus"
  environment          = var.environment
  vpc_id               = module.network.vpc_id
  subnet_id            = values(module.network.public_subnet_ids)[0]
  instance_type        = var.nexus_instance_type
  root_volume_size     = var.nexus_root_volume_size
  data_volume_size     = var.nexus_data_volume_size
  data_device_name     = var.data_device_name
  data_mount_path      = var.nexus_data_mount_path
  web_port             = var.nexus_port
  docker_registry_port = var.nexus_docker_port
  nexus_version        = var.nexus_version
  key_name             = var.key_name
  allowed_cidr_blocks  = var.platform_tools_allowed_cidrs
  monitoring           = var.platform_monitoring
  ami_name_filter      = var.ami_name_filter
  ssm_policy_arn       = var.ssm_policy_arn
}

module "platform_alb" {
  source                             = "../../modules/platform-tools/alb"
  environment                        = var.environment
  internal_alb                       = var.internal_alb
  vpc_id                             = module.network.vpc_id
  subnet_ids                         = values(module.network.public_subnet_ids)
  jenkins_instance_id                = module.jenkins.instance_id
  sonarqube_instance_id              = module.sonarqube.instance_id
  nexus_instance_id                  = module.nexus.instance_id
  jenkins_port                       = var.jenkins_port
  sonarqube_port                     = var.sonarqube_port
  nexus_port                         = var.nexus_port
  nexus_docker_port                  = var.nexus_docker_port
  allowed_cidr_blocks                = var.platform_tools_allowed_cidrs
  health_check_interval              = var.alb_health_check_interval
  health_check_healthy_threshold     = var.alb_health_check_healthy_threshold
  health_check_unhealthy_threshold   = var.alb_health_check_unhealthy_threshold
  jenkins_health_check_path          = var.jenkins_health_check_path
  jenkins_health_check_matcher       = var.jenkins_health_check_matcher
  sonarqube_health_check_path        = var.sonarqube_health_check_path
  sonarqube_health_check_matcher     = var.sonarqube_health_check_matcher
  nexus_health_check_path            = var.nexus_health_check_path
  nexus_health_check_matcher         = var.nexus_health_check_matcher
  nexus_docker_health_check_path     = var.nexus_docker_health_check_path
  nexus_docker_health_check_matcher = var.nexus_docker_health_check_matcher
}

# ==========================================
# FRONTEND CONFIGURATIONS & NUMERIC DEFAULTS
# ==========================================

variable "key_name" {
  type        = string
  description = "EC2 Key Pair Name"
  default     = "terraform22-key"
}

variable "data_device_name" {
  type        = string
  description = "Block device name for EBS volume attachment"
  default     = "/dev/xvdf"
}

variable "ami_name_filter" {
  type        = string
  description = "AMI name filter for Amazon Linux"
  default     = "al2023-ami-2023.*-x86_64"
}

variable "ssm_policy_arn" {
  type        = string
  description = "IAM Policy ARN for Systems Manager SSM"
  default     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Software Version Variables
variable "jenkins_version" {
  type        = string
  description = "Jenkins native package version"
  default     = "2.568.3"
}

variable "sonarqube_version" {
  type        = string
  description = "SonarQube container image version tag"
  default     = "community"
}

variable "postgres_version" {
  type        = string
  description = "PostgreSQL container image version tag"
  default     = "15-alpine"
}

variable "nexus_version" {
  type        = string
  description = "Nexus container image version tag"
  default     = "latest"
}

# Jenkins Frontend Variables
variable "jenkins_instance_type" {
  type        = string
  description = "Instance type for Jenkins"
  default     = "t3.xlarge"
}

variable "jenkins_root_volume_size" {
  type        = number
  description = "Root volume size for Jenkins (GB)"
  default     = 30
}

variable "jenkins_data_volume_size" {
  type        = number
  description = "Data volume size for Jenkins (GB)"
  default     = 100
}

variable "jenkins_data_mount_path" {
  type        = string
  description = "Mount path for Jenkins home"
  default     = "/var/lib/jenkins"
}

variable "jenkins_port" {
  type        = number
  description = "Port for Jenkins ALB listener & target group"
  default     = 8080
}

variable "jenkins_jnlp_port" {
  type        = number
  description = "Jenkins Agent JNLP port"
  default     = 50000
}

# SonarQube Frontend Variables
variable "sonarqube_instance_type" {
  type        = string
  description = "Instance type for SonarQube"
  default     = "t3.medium"
}

variable "sonarqube_root_volume_size" {
  type        = number
  description = "Root volume size for SonarQube (GB)"
  default     = 30
}

variable "sonarqube_data_volume_size" {
  type        = number
  description = "Data volume size for SonarQube (GB)"
  default     = 50
}

variable "sonarqube_data_mount_path" {
  type        = string
  description = "Mount path for SonarQube data"
  default     = "/opt/sonarqube_data"
}

variable "sonarqube_port" {
  type        = number
  description = "Port for SonarQube ALB listener & target group"
  default     = 9000
}

variable "sonarqube_db_username" {
  type        = string
  description = "PostgreSQL DB username for SonarQube"
  default     = "sonar"
}

variable "sonarqube_db_password" {
  type        = string
  description = "PostgreSQL DB password for SonarQube (optional, auto-generated if empty)"
  sensitive   = true
  default     = ""
}

variable "sonarqube_db_name" {
  type        = string
  description = "PostgreSQL DB name for SonarQube"
  default     = "sonar"
}

variable "sysctl_max_map_count" {
  type        = number
  description = "Linux kernel sysctl vm.max_map_count limit"
  default     = 524288
}

variable "sysctl_fs_file_max" {
  type        = number
  description = "Linux kernel sysctl fs.file-max limit"
  default     = 131072
}

variable "db_init_sleep" {
  type        = number
  description = "Sleep duration in seconds for PostgreSQL initialization"
  default     = 10
}

# Nexus Frontend Variables
variable "nexus_instance_type" {
  type        = string
  description = "Instance type for Nexus"
  default     = "t3.large"
}

variable "nexus_root_volume_size" {
  type        = number
  description = "Root volume size for Nexus (GB)"
  default     = 30
}

variable "nexus_data_volume_size" {
  type        = number
  description = "Data volume size for Nexus (GB)"
  default     = 200
}

variable "nexus_data_mount_path" {
  type        = string
  description = "Mount path for Nexus data"
  default     = "/nexus-data"
}

variable "nexus_port" {
  type        = number
  description = "Port for Nexus ALB listener & target group"
  default     = 8081
}

variable "nexus_docker_port" {
  type        = number
  description = "Port for Nexus Docker Registry ALB listener & target group"
  default     = 8082
}

variable "platform_tools_allowed_cidrs" {
  type        = list(string)
  description = "Allowed CIDR blocks for platform tools"
  default     = ["0.0.0.0/0"]
}

# CloudWatch Monitoring Frontend Object
variable "platform_monitoring" {
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
  description = "Frontend CloudWatch monitoring configuration"
  default = {
    enabled = true
    cpu = {
      enabled            = true
      threshold          = 85
      period             = 300
      evaluation_periods = 2
      statistic          = "Average"
    }
    status_check = {
      enabled            = true
      threshold          = 0
      period             = 60
      evaluation_periods = 2
      statistic          = "Maximum"
    }
  }
}

# ALB Frontend Settings
variable "alb_health_check_interval" {
  type        = number
  description = "ALB Health check interval in seconds"
  default     = 30
}

variable "alb_health_check_healthy_threshold" {
  type        = number
  description = "ALB Health check healthy threshold"
  default     = 2
}

variable "alb_health_check_unhealthy_threshold" {
  type        = number
  description = "ALB Health check unhealthy threshold"
  default     = 3
}

variable "jenkins_health_check_path" {
  type        = string
  description = "Jenkins health check path"
  default     = "/login"
}

variable "jenkins_health_check_matcher" {
  type        = string
  description = "Jenkins health check HTTP matcher"
  default     = "200-399"
}

variable "sonarqube_health_check_path" {
  type        = string
  description = "SonarQube health check path"
  default     = "/"
}

variable "sonarqube_health_check_matcher" {
  type        = string
  description = "SonarQube health check HTTP matcher"
  default     = "200-399"
}

variable "nexus_health_check_path" {
  type        = string
  description = "Nexus health check path"
  default     = "/"
}

variable "nexus_health_check_matcher" {
  type        = string
  description = "Nexus health check HTTP matcher"
  default     = "200-399"
}

variable "nexus_docker_health_check_path" {
  type        = string
  description = "Nexus Docker Registry health check path"
  default     = "/v2/"
}

variable "nexus_docker_health_check_matcher" {
  type        = string
  description = "Nexus Docker Registry health check HTTP matcher"
  default     = "200-499"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for Internal ALB placement"
  default     = []
}

variable "internal_alb" {
  type        = bool
  description = "Whether the ALB is internal"
  default     = false
}
