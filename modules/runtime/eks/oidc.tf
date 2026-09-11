resource "aws_iam_openid_connect_provider" "eks" {
  count           = var.create_irsa ? 1 : 0
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks[0].certificates[0].sha1_fingerprint]
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-oidc"
    }
  )
}
