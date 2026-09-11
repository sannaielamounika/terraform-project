variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name_prefix" {
  type        = string
  description = "Resource naming prefix"
  default     = "speshway"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB and Target Group are deployed"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for public ALB placement"
}

variable "gateway_target_port" {
  type        = number
  description = "Container target port for gateway service"
  default     = 8080
}

variable "health_check_path" {
  type        = string
  description = "Health check endpoint path"
  default     = "/actuator/health"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
  default     = {}
}
