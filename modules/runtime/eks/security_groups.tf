resource "aws_security_group" "cluster" {
  name        = local.cluster_security_group_name
  description = "Security group for EKS control plane"
  vpc_id      = var.vpc_id
  tags = merge(
    local.common_tags,
    {
      Name = local.cluster_security_group_name
    }
  )
}

resource "aws_vpc_security_group_egress_rule" "cluster_all_egress" {
  security_group_id = aws_security_group.cluster.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "node" {
  name        = local.node_security_group_name
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id
  tags = merge(
    local.common_tags,
    {
      Name                     = local.node_security_group_name
      "karpenter.sh/discovery" = "${var.environment}-speshway"
    }
  )
}

resource "aws_vpc_security_group_egress_rule" "node_all_egress" {
  security_group_id = aws_security_group.node.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "node_from_cluster" {
  security_group_id            = aws_security_group.node.id
  referenced_security_group_id = aws_security_group.cluster.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "node_to_node" {
  security_group_id            = aws_security_group.node.id
  referenced_security_group_id = aws_security_group.node.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "cluster_from_node_all" {
  security_group_id            = aws_security_group.cluster.id
  referenced_security_group_id = aws_security_group.node.id
  ip_protocol                  = "-1"
}
