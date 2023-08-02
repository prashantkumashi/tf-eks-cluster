### Enabling IAM Roles for Service Accounts  for aws-node pod
data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.sampleprivatecluster-cluster.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.sampleprivatecluster-cluster.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "cluster" {
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json
  name               = format("irsa-%s-aws-node", aws_eks_cluster.sampleprivatecluster.name)
}


resource "aws_iam_role" "sampleprivatecluster-cluster" {
  name = "terraform-eks-sampleprivatecluster-cluster"

  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = [
              "eks-fargate-pods.amazonaws.com",
              "eks.amazonaws.com",
            ]
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = false
  max_session_duration  = 3600
  path                  = "/"
  tags = {
    "Name"  = "eks-cluster/ServiceRole"

  }
}

resource "aws_iam_role_policy_attachment" "sampleprivatecluster-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.sampleprivatecluster-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "sampleprivatecluster-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.sampleprivatecluster-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-ServiceRole-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "${aws_iam_role.sampleprivatecluster-cluster.name}"
}

resource "aws_iam_role_policy" "eks-cluster-ServiceRole-eks-cluster-PolicyCloudWatchMetrics" {
  name = "eks-cluster-PolicyCloudWatchMetrics"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "cloudwatch:PutMetricData",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
  role       = "${aws_iam_role.sampleprivatecluster-cluster.name}"
}


resource "aws_iam_role_policy" "eks-cluster-ServiceRole-eks-cluster-PolicyELBPermissions" {
  name = "eks-cluster-PolicyELBPermissions"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "ec2:DescribeAccountAttributes",
            "ec2:DescribeAddresses",
            "ec2:DescribeInternetGateways",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
  role       = "${aws_iam_role.sampleprivatecluster-cluster.name}"
}
