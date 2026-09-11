aws_region   = "us-east-1"
environment  = "prod"
project_name = "my-company-tfstate"
tags = {
  Environment = "production"
  ManagedBy   = "Terraform"
  Team        = "DevOps"
}
noncurrent_version_expiration_days = 90
