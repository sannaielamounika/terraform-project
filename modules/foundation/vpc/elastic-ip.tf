resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.this]
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nat-eip"
  })
}
