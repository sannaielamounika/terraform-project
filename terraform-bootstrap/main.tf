# Fetch current AWS account details dynamically
data "aws_caller_identity" "current" {}

# Fetch current AWS region details dynamically
data "aws_region" "current" {}

# Generate a random 4-character suffix for unique resource naming
resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  account_id  = data.aws_caller_identity.current.account_id
}
