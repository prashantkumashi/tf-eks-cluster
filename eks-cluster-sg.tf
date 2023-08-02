
resource "aws_security_group" "sampleprivatecluster-cluster-sg" {
  name        = "terraform-eks-sampleprivatecluster-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.sampleprivatecluster.id}"

  tags = {
    Name = "terraform-eks-sampleprivatecluster"
  }
}
resource "aws_security_group_rule" "eks-all-self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self = true
  security_group_id = "${aws_security_group.sampleprivatecluster-cluster-sg.id}"
}

resource "aws_security_group_rule" "eks-all-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.sampleprivatecluster-cluster-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "eks-all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.sampleprivatecluster.cidr_block}"]
  security_group_id = "${aws_security_group.sampleprivatecluster-cluster-sg.id}"
}


resource "aws_security_group_rule" "eks-all-node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = "${aws_security_group.allnodes-sg.id}"
  security_group_id = "${aws_security_group.sampleprivatecluster-cluster-sg.id}"
}
