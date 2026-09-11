variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Target Groups and Security Groups are created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ALB placement"
}

variable "jenkins_port" {
  type        = number
  description = "Port for Jenkins target group and listener"
}

variable "sonarqube_port" {
  type        = number
  description = "Port for SonarQube target group and listener"
}

variable "nexus_port" {
  type        = number
  description = "Port for Nexus target group and listener"
}

variable "nexus_docker_port" {
  type        = number
  description = "Port for Nexus Docker registry target group and listener"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Allowed CIDR blocks for ingress"
}

variable "jenkins_instance_id" {
  type        = string
  description = "EC2 Instance ID for Jenkins server"
}

variable "sonarqube_instance_id" {
  type        = string
  description = "EC2 Instance ID for SonarQube server"
}

variable "nexus_instance_id" {
  type        = string
  description = "EC2 Instance ID for Nexus server"
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer to create"
  default     = "application"
}

variable "internal_alb" {
  type        = bool
  description = "Whether the ALB is internal or internet-facing"
  default     = false
}

variable "enable_deletion_protection" {
  type        = bool
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  default     = false
}

variable "target_type" {
  type        = string
  description = "Type of target that you specify when registering targets"
  default     = "instance"
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets"
  default     = "HTTP"
}

variable "default_listener_port" {
  type        = number
  description = "Default HTTP listener port"
  default     = 80
}

variable "https_port" {
  type        = number
  description = "HTTPS listener port"
  default     = 443
}

variable "health_check_interval" {
  type        = number
  description = "Amount of time between health checks of an individual target in seconds"
}

variable "health_check_healthy_threshold" {
  type        = number
  description = "Number of consecutive health checks successes required"
}

variable "health_check_unhealthy_threshold" {
  type        = number
  description = "Number of consecutive health check failures required"
}

variable "jenkins_health_check_path" {
  type        = string
  description = "Health check path for Jenkins"
}

variable "jenkins_health_check_matcher" {
  type        = string
  description = "HTTP code matcher for Jenkins health check"
}

variable "sonarqube_health_check_path" {
  type        = string
  description = "Health check path for SonarQube"
}

variable "sonarqube_health_check_matcher" {
  type        = string
  description = "HTTP code matcher for SonarQube health check"
}

variable "nexus_health_check_path" {
  type        = string
  description = "Health check path for Nexus"
}

variable "nexus_health_check_matcher" {
  type        = string
  description = "HTTP code matcher for Nexus health check"
}

variable "nexus_docker_health_check_path" {
  type        = string
  description = "Health check path for Nexus Docker Registry"
}

variable "nexus_docker_health_check_matcher" {
  type        = string
  description = "HTTP code matcher for Nexus Docker Registry health check"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
