resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id
  tags = merge(local.common_tags, {
    Name = "${var.environment}-nat-gw"
  })
  depends_on = [aws_internet_gateway.this]
}
