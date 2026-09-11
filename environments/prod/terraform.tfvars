aws_region  = "us-east-1"
environment = "prod"

vpc_cidr = "10.100.0.0/16"
public_subnets = {
  "pub-1a" = {
    cidr_block        = "10.100.1.0/24"
    availability_zone = "us-east-1a"
  }
  "pub-1b" = {
    cidr_block        = "10.100.2.0/24"
    availability_zone = "us-east-1b"
  }
  "pub-1c" = {
    cidr_block        = "10.100.3.0/24"
    availability_zone = "us-east-1c"
  }
}

private_subnets = {
  "priv-1a" = {
    cidr_block        = "10.100.10.0/24"
    availability_zone = "us-east-1a"
  }
  "priv-1b" = {
    cidr_block        = "10.100.20.0/24"
    availability_zone = "us-east-1b"
  }
  "priv-1c" = {
    cidr_block        = "10.100.30.0/24"
    availability_zone = "us-east-1c"
  }
}

s3_buckets = {
  app_data = {
    bucket_name       = "mycompany-prod-app-data-storage"
    versioning_status = "Enabled"
    force_destroy     = false
  }
  audit_logs = {
    bucket_name       = "mycompany-prod-audit-logs"
    versioning_status = "Enabled"
    force_destroy     = false
  }
}

kms_keys = {
  prod_master = {
    alias_name              = "alias/prod-master-key"
    description             = "Production CMK for S3, Database, and Secrets Manager"
    deletion_window_in_days = 30
    enable_key_rotation     = true
  }
}

prod_secrets = {
  database_credentials = {
    name        = "prod/app/postgres"
    description = "Production Database Credentials"
    payload = {
      username = "prod_db_master"
      password = "SuperSecretProdPassword2026!#$"
      port     = "5432"
      engine   = "postgres"
    }
  }
}

# ==========================================
# PLATFORM TOOLS CONFIGURATION (PROD)
# ==========================================
jenkins_instance_type        = "c6i.2xlarge"
jenkins_data_volume_size     = 300

sonarqube_instance_type      = "m6i.xlarge"
sonarqube_data_volume_size   = 150
sonarqube_db_password        = "SonarProdSecret2026!"

nexus_instance_type          = "m6i.2xlarge"
nexus_data_volume_size       = 500

platform_tools_allowed_cidrs = ["0.0.0.0/0"]

# ALB PORT & CIDR CONFIGURATION
jenkins_port       = 8080
sonarqube_port     = 9000
nexus_port         = 8081
nexus_docker_port  = 8082

internal_alb       = true
