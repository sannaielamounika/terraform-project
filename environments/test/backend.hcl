bucket         = "my-company-tfstate-prod-475345973578-d530"
key            = "environments/test/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "my-company-tfstate-prod-locks"
encrypt        = true
kms_key_id     = "arn:aws:kms:us-east-1:475345973578:key/73de95f3-f733-41ce-b8d6-a2c31ac8fa4c"
