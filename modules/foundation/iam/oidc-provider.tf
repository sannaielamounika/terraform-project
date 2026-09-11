resource "aws_iam_openid_connect_provider" "eks" {
  count           = var.create_oidc_provider && var.eks_oidc_issuer_url != "" ? 1 : 0
  url             = "https://${var.eks_oidc_issuer_url}"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks[0].certificates[0].sha1_fingerprint]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-eks-oidc-provider"
    }
  )
}
