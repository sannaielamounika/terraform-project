resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags = merge(local.common_tags, {
    Name                     = "${var.environment}-public-${each.key}"
    Type                     = "Public"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = merge(local.common_tags, {
    Name                              = "${var.environment}-private-${each.key}"
    Type                              = "Private"
    "kubernetes.io/role/internal-elb" = "1"
    "karpenter.sh/discovery"          = "${var.environment}-speshway"
  })
}
