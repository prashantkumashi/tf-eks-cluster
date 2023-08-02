## OIDC Provider
data "tls_certificate" "cluster" {
  url = aws_eks_cluster.empyern.identity.0.oidc.0.issuer
}
resource "aws_iam_openid_connect_provider" "empyern-cluster" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster.certificates.0.sha1_fingerprint]
  url = aws_eks_cluster.empyern.identity.0.oidc.0.issuer
}


### Enabling IAM Roles for Service Accounts  for aws-node pod
data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.empyern-cluster.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.empyern-cluster.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "cluster" {
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json
  name               = format("irsa-%s-aws-node", aws_eks_cluster.empyern.name)
}

output oidc_provider_arn {
  value=aws_iam_openid_connect_provider.empyern-cluster.arn
}
