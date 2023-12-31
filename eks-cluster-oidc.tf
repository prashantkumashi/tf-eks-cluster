### OIDC Provider
data "tls_certificate" "cluster" {
  url = aws_eks_cluster.sampleprivatecluster.identity.0.oidc.0.issuer
}
resource "aws_iam_openid_connect_provider" "sampleprivatecluster-cluster" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster.certificates.0.sha1_fingerprint]
  url = aws_eks_cluster.sampleprivatecluster.identity.0.oidc.0.issuer
}

output oidc_provider_arn {
  value=aws_iam_openid_connect_provider.sampleprivatecluster-cluster.arn
}
