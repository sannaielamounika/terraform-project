# AWS Region Data Source
data "aws_region" "current" {}

# Security Group for VPC-Interface-Endpoints
resource "aws_security_group" "vpc_endpoints" {
  name        = "${local.name_prefix}-${var.environment}-vpc-endpoints-sg"
  description = "Security group for VPC-Interface-Endpoints"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow inbound HTTPS from VPCCIDR"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-${var.environment}-vpc-endpoints-sg"
  })
}

# S3 Gateway-Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id, aws_route_table.public.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-${var.environment}-s3-gateway-endpoint"
  })
}

# ECR API-Interface-Endpoint
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for k, v in aws_subnet.private : v.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-${var.environment}-ecr-api-endpoint"
  })
}

# ECR DKR-Interface-Endpoint
resource "aws_vpc_endpoint" "ecr_dlr" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for k, v in aws_subnet.private : v.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-${var.environment}-ecr-dkr-endpoint"
  })
}

# EC2-Interface-Endpoint
resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for k, v in aws_subnet.private : v.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-${var.environment}-ec2-endpoint"
  })
}

# STS-Interface-Endpoint
resource "aws_vpc_endpoint" "sts" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.sts"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for k, v in aws_subnet.private : v.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-${var.environment}-sts-endpoint"
  })
}
