terraform {
  backend "s3" {}
}

module "kms" {
  for_each                = var.kms_keys
  source                  = "../../modules/foundation/kms"
  environment             = var.environment
  alias_name              = each.value.alias_name
  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days
  enable_key_rotation     = each.value.enable_key_rotation
}

module "network" {
  source          = "../../modules/foundation/vpc"
  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "iam" {
  source                      = "../../modules/foundation/iam"
  environment                 = var.environment
  create_permissions_boundary = true
  roles = {
    app_runner = {
      assume_role_service = "ec2"
      policy_arns         = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
    }
  }
  instance_profiles = {
    app_server = {
      role_name = "app_runner"
    }
  }
}

module "s3_buckets" {
  for_each           = var.s3_buckets
  source             = "../../modules/foundation/s3"
  bucket_name        = each.value.bucket_name
  environment        = var.environment
  versioning_status  = each.value.versioning_status
  force_destroy      = each.value.force_destroy
  kms_master_key_arn = module.kms["prod_master"].key_arn
}

module "secrets_manager" {
  for_each                = var.prod_secrets
  source                  = "../../modules/foundation/secrets-manager"
  secret_name             = each.value.name
  description             = each.value.description
  environment             = var.environment
  secret_string_map       = each.value.payload
  kms_key_id              = module.kms["prod_master"].key_arn
  recovery_window_in_days = 30
}
