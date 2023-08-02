resource "aws_eks_addon" "vpc-cni" {
  depends_on     = [aws_eks_node_group.ng1]
  cluster_name = aws_eks_cluster.empyern.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "kube-proxy" {
  depends_on     = [aws_eks_node_group.ng1]
  cluster_name = aws_eks_cluster.empyern.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "coredns" {
  depends_on     = [aws_eks_node_group.ng1]
  cluster_name = aws_eks_cluster.empyern.name
  addon_name   = "coredns"
}
