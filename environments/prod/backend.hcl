bucket         = "prod-infra-bootstrap-tf-state-bucket"
key            = "environments/prod/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "prod-infra-bootstrap-tf-locks"
encrypt        = true
