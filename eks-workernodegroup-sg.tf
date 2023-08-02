resource "aws_security_group" "allnodes-sg" {
  description = "Communication between all nodes in the cluster"
  vpc_id      = "${aws_vpc.sampleprivatecluster.id}"
  tags = {
    "Name"   = format("eks-%s-cluster/ClusterSharedNodeSecurityGroup",var.cluster-name)
    "Label"  = "TF-EKS All Nodes Comms"
  }
}

resource "aws_security_group_rule" "eks-node" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.sampleprivatecluster.cidr_block}"]
  security_group_id = "${aws_security_group.allnodes-sg.id}"
}

resource "aws_security_group_rule" "eks-node-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.allnodes-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-node-self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self = true
  security_group_id = "${aws_security_group.allnodes-sg.id}"
}

resource "aws_security_group_rule" "eks-node-all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = "${aws_security_group.sampleprivatecluster-cluster-sg.id}"
  security_group_id = "${aws_security_group.allnodes-sg.id}"
}
