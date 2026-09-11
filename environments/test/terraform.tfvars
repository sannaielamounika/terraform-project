aws_region   = "us-east-1"
environment  = "test"
project_name = "speshway"
owner        = "DevOps-Team"

vpc_cidr = "10.120.0.0/16"
public_subnets = {
  public_1a = {
    cidr_block        = "10.120.1.0/24"
    availability_zone = "us-east-1a"
  }
  public_1b = {
    cidr_block        = "10.120.2.0/24"
    availability_zone = "us-east-1b"
  }
}

private_subnets = {
  private_1a = {
    cidr_block        = "10.120.10.0/24"
    availability_zone = "us-east-1a"
  }
  private_1b = {
    cidr_block        = "10.120.20.0/24"
    availability_zone = "us-east-1b"
  }
}

kms_keys = {
  test_master = {
    alias_name           = "alias/speshway-test-master"
    description          = "Test environment encryption key"
    deletion_window_days = 7
    enable_key_rotation  = true
  }
}

s3_buckets = {
  app_data = {
    bucket_name   = "speshway-test-app-data"
    force_destroy = true
  }
}

secrets = {
  database_credentials = {
    name        = "speshway/test/database"
    description = "Test database credentials"
  }
}

ecr_repositories = {
  gateway_service      = { name = "speshway-test-gateway-service" }
  auth_service         = { name = "speshway-test-auth-service" }
  user_service         = { name = "speshway-test-user-service" }
  lead_service         = { name = "speshway-test-lead-service" }
  customer_service     = { name = "speshway-test-customer-service" }
  contact_service      = { name = "speshway-test-contact-service" }
  opportunity_service  = { name = "speshway-test-opportunity-service" }
  quotation_service    = { name = "speshway-test-quotation-service" }
  invoice_service      = { name = "speshway-test-invoice-service" }
  task_service         = { name = "speshway-test-task-service" }
  notification_service = { name = "speshway-test-notification-service" }
  file_service         = { name = "speshway-test-file-service" }
  report_service       = { name = "speshway-test-report-service" }
  audit_service        = { name = "speshway-test-audit-service" }
}

eks_cluster_name            = "speshway-test-eks"
eks_version                 = "1.33"
eks_endpoint_private_access = true
eks_endpoint_public_access  = true

rds_identifier              = "speshway-test-db"
rds_engine                  = "mysql"
rds_engine_version          = "8.0"
rds_parameter_group_family  = "mysql8.0"
rds_instance_class          = "db.t3.micro"
rds_database_name           = "tenantcrm"
rds_username                = "crm_admin"
rds_port                    = 3306
rds_backup_retention_period = 7
rds_multi_az                = false

enable_karpenter         = false
karpenter_namespace      = "kube-system"
karpenter_node_role_name = "speshway-test-karpenter-node"

# ==========================================
# PLATFORM TOOLS CONFIGURATION (TEST)
# ==========================================
jenkins_instance_type    = "t3.xlarge"
jenkins_data_volume_size = 100

sonarqube_instance_type    = "t3.medium"
sonarqube_data_volume_size = 50
sonarqube_db_password      = "SonarTestSecret2026!"

nexus_instance_type    = "t3.large"
nexus_data_volume_size = 200

platform_tools_allowed_cidrs = ["0.0.0.0/0"]

# ALB PORT & CIDR CONFIGURATION
jenkins_port      = 8080
sonarqube_port    = 9000
nexus_port        = 8081
nexus_docker_port = 8082

internal_alb = false
