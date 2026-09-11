variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, test, stage, prod)"
}

variable "name_prefix" {
  type        = string
  description = "Resource naming prefix"
  default     = "speshway"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  description = "Map of public subnet configurations"
  default     = {}
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  description = "Map of private subnet configurations"
  default     = {}
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Optional list of public subnet CIDRs for count-based fallback"
  default     = []
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Optional list of private subnet CIDRs for count-based fallback"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default     = {}
}
