module "network" {
  source          = "../../modules/foundation/vpc"
  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "kms" {
  for_each             = var.kms_keys
  source               = "../../modules/foundation/kms"
  environment          = var.environment
  alias_name           = each.value.alias_name
  description          = each.value.description
  deletion_window_days = each.value.deletion_window_days
  enable_key_rotation  = each.value.enable_key_rotation
}

module "iam" {
  source                      = "../../modules/foundation/iam"
  environment                 = var.environment
  create_permissions_boundary = var.environment == "dev"
  roles = {
    application = {
      assume_role_service = "ec2"
      policy_arns         = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
    }
  }
  instance_profiles = {
    application = {
      role_name = "application"
    }
  }
}

module "s3" {
  for_each           = var.s3_buckets
  source             = "../../modules/foundation/s3"
  environment        = var.environment
  bucket_name        = each.value.bucket_name
  force_destroy      = each.value.force_destroy
  kms_master_key_arn = module.kms["dev_master"].key_arn
}

module "secrets_manager" {
  for_each                = var.secrets
  source                  = "../../modules/foundation/secrets-manager"
  environment             = var.environment
  secret_name             = each.value.name
  description             = each.value.description
  kms_key_id              = module.kms["dev_master"].key_arn
  recovery_window_in_days = 7
}

module "ecr" {
  for_each        = var.ecr_repositories
  source          = "../../modules/runtime/ecr"
  environment     = var.environment
  repository_name = each.value.name
}

module "eks" {
  source                  = "../../modules/runtime/eks"
  environment             = var.environment
  cluster_name            = var.eks_cluster_name
  cluster_version         = var.eks_version
  vpc_id                  = module.network.vpc_id
  subnet_ids              = values(module.network.private_subnet_ids)
  endpoint_private_access = var.eks_endpoint_private_access
  endpoint_public_access  = var.eks_endpoint_public_access
}

module "rds" {
  source                  = "../../modules/runtime/rds"
  environment             = var.environment
  identifier              = var.rds_identifier
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  instance_class          = var.rds_instance_class
  database_name           = var.rds_database_name
  username                = var.rds_username
  port                    = var.rds_port
  subnet_ids              = values(module.network.private_subnet_ids)
  multi_az                = var.rds_multi_az
  backup_retention_period = var.rds_backup_retention_period
  kms_key_arn             = module.kms["dev_master"].key_arn
}

module "karpenter" {
  count                  = var.enable_karpenter ? 1 : 0
  source                 = "../../modules/runtime/eks/karpenter"
  environment            = var.environment
  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_certificate_authority
  private_subnet_ids     = values(module.network.private_subnet_ids)
  node_role_name         = var.karpenter_node_role_name
  namespace              = var.karpenter_namespace
}
