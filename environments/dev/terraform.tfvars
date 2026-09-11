aws_region   = "us-east-1"
environment  = "dev"
project_name = "speshway"
owner        = "DevOps-Team"

vpc_cidr = "10.110.0.0/16"
public_subnets = {
  public_1a = {
    cidr_block        = "10.110.1.0/24"
    availability_zone = "us-east-1a"
  }
  public_1b = {
    cidr_block        = "10.110.2.0/24"
    availability_zone = "us-east-1b"
  }
}

private_subnets = {
  private_1a = {
    cidr_block        = "10.110.10.0/24"
    availability_zone = "us-east-1a"
  }
  private_1b = {
    cidr_block        = "10.110.20.0/24"
    availability_zone = "us-east-1b"
  }
}

kms_keys = {
  dev_master = {
    alias_name           = "alias/speshway-dev-master"
    description          = "Development encryption key"
    deletion_window_days = 7
    enable_key_rotation  = true
  }
}

s3_buckets = {
  app_data = {
    bucket_name   = "speshway-dev-app-data"
    force_destroy = true
  }
}

secrets = {
  database_credentials = {
    name        = "speshway/dev/database"
    description = "Development database credentials"
  }
}

ecr_repositories = {
  frontend = {
    name = "speshway-dev-frontend"
  }
  backend = {
    name = "speshway-dev-backend"
  }
  auth = {
    name = "speshway-dev-auth"
  }
}

eks_cluster_name            = "speshway-dev-eks"
eks_version                 = "1.33"
eks_endpoint_private_access = true
eks_endpoint_public_access  = true

rds_identifier              = "speshway-dev-db"
rds_engine                  = "postgres"
rds_engine_version          = "17"
rds_instance_class          = "db.t3.micro"
rds_database_name           = "speshway"
rds_username                = "speshway_admin"
rds_port                    = 5432
rds_backup_retention_period = 7
rds_multi_az                = false

enable_karpenter         = true
karpenter_namespace      = "kube-system"
karpenter_node_role_name = "speshway-dev-karpenter-node"

# ==========================================
# PLATFORM TOOLS CONFIGURATION (DEV)
# ==========================================
jenkins_instance_type        = "t3.large"
jenkins_data_volume_size     = 50

sonarqube_instance_type      = "t3.medium"
sonarqube_data_volume_size   = 30
sonarqube_db_password        = "SonarDevSecret2026!"

nexus_instance_type          = "t3.medium"
nexus_data_volume_size       = 100

platform_tools_allowed_cidrs = ["0.0.0.0/0"]

# ALB PORT & CIDR CONFIGURATION
jenkins_port       = 8080
sonarqube_port     = 9000
nexus_port         = 8081
nexus_docker_port  = 8082

internal_alb       = true
