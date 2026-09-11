# Terraform Enterprise Infrastructure

Enterprise-grade Infrastructure as Code (IaC) repository for AWS infrastructure management using Terraform.

## Repository Structure

`
├── terraform-bootstrap/ # Initial S3 backend bucket & DynamoDB state locking setup
├── modules/             # Modular reusable infrastructure components
│   ├── foundation/      # VPC, S3, KMS, IAM, Secrets Manager
│   ├── runtime/         # EKS, RDS, ECR, ALB
│   └── platform-tools/  # Jenkins, SonarQube, Nexus, Platform ALB
└── environments/        # Environment configurations
    ├── dev/             # Development environment configuration
    ├── test/            # Test environment configuration
    └── prod/            # Production environment configuration
`

## Setup & Deployment

1. **Bootstrap State Backend**:
   `ash
   cd terraform-bootstrap
   terraform init
   terraform apply
   `

2. **Deploy Environment** (e.g., Test):
   `ash
   cd environments/test
   terraform init -backend-config=backend.hcl
   terraform plan
   terraform apply
   `
