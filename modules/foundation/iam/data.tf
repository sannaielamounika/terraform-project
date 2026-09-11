data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "tls_certificate" "eks" {
  count = var.create_oidc_provider && var.eks_oidc_issuer_url != "" ? 1 : 0
  url   = "https://${var.eks_oidc_issuer_url}"
}
