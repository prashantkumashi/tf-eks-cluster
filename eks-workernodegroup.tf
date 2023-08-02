
resource "aws_eks_node_group" "ng1" {
  depends_on     = [
      aws_iam_role_policy_attachment.sampleprivatecluster-ng-AmazonEKSWorkerNodePolicy,
      aws_iam_role_policy_attachment.sampleprivatecluster-ng-AmazonEKS_CNI_Policy,
      aws_iam_role_policy_attachment.sampleprivatecluster-ng-AmazonEC2ContainerRegistryReadOnly,
	  aws_launch_template.lt-ng1,
	  aws_route_table_association.sampleprivatecluster-worker-private-1-a,
	  aws_route_table_association.sampleprivatecluster-worker-private-2-b,
	  aws_route_table_association.sampleprivatecluster-worker-private-3-c,
	  aws_eks_cluster.sampleprivatecluster
  ]
  cluster_name   = aws_eks_cluster.sampleprivatecluster.name
  disk_size      = 0
  instance_types = []

  labels = {
    "eks/cluster-name"   = aws_eks_cluster.sampleprivatecluster.name
    "eks/nodegroup-name" = format("ng1-%s", aws_eks_cluster.sampleprivatecluster.name)
  }
  node_group_name = format("ng1-%s", aws_eks_cluster.sampleprivatecluster.name)
  node_role_arn   = aws_iam_role.sampleprivatecluster-node-role.arn
 
  subnet_ids      = ["${aws_subnet.sampleprivatecluster-worker-private-1.id}", "${aws_subnet.sampleprivatecluster-worker-private-2.id}", "${aws_subnet.sampleprivatecluster-worker-private-3.id}"]
  tags = {
    "eks/cluster-name"                = aws_eks_cluster.sampleprivatecluster.name
    "eks/eksctl-version"              = "0.29.2"
    "eks/nodegroup-name"              = format("ng1-%s", aws_eks_cluster.sampleprivatecluster.name)
    "eks/nodegroup-type"              = "managed"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = aws_eks_cluster.sampleprivatecluster.name
	"role"                            = "eks-worker"
	"kubernetes.io/cluster/${var.cluster-name}" = "owned"
	"environment"                     = "dev"
  }

  launch_template {
    name    = aws_launch_template.lt-ng1.name
    version = "$Latest"
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  timeouts {}
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
  type = string 
  default = "AL2_x86_64"
}
