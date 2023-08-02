#
# EKS Cluster Resources
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_kms_key" "ekskey" {
  description             = format("EKS KMS Key %s",var.cluster-name)
}

resource "aws_eks_cluster" "sampleprivatecluster" {
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.sampleprivatecluster-cluster.arn}"
  
  version    = "1.20"

  vpc_config {
	endpoint_private_access = true
	endpoint_public_access  = false
	public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids = ["${aws_security_group.sampleprivatecluster-cluster-sg.id}"]
    subnet_ids         = ["${aws_subnet.sampleprivatecluster-worker-private-1.id}", "${aws_subnet.sampleprivatecluster-worker-private-2.id}", "${aws_subnet.sampleprivatecluster-worker-private-3.id}"]

  }
  encryption_config  {
    provider  {
      key_arn = aws_kms_key.ekskey.arn
    }
    resources = ["secrets"]
  }
}


output cluster-name {
  value=aws_eks_cluster.sampleprivatecluster.name
}

output cluster-sg {
  value=aws_eks_cluster.sampleprivatecluster.vpc_config[0].cluster_security_group_id
}

output ca {
  value=aws_eks_cluster.sampleprivatecluster.certificate_authority[0].data
}

output endpoint {
  value=aws_eks_cluster.sampleprivatecluster.endpoint
}
