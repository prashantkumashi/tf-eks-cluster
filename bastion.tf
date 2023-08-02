
resource "aws_security_group" "ingress-all-bastion" {
name = "allow-all-sg"
vpc_id = "${aws_vpc.sampleprivatecluster.id}"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "eksbastion-launchconfig" {
  name_prefix      = "bastion-launchconfig"
#  image_id         = "${lookup(var.AMIS, var.AWS_REGION)}"
  image_id         = var.AMIS["${var.AWS_REGION}"]
  instance_type    = "t2.micro"
  key_name         = "${var.ami_key_pair_name}"
  security_groups  = ["${aws_security_group.ingress-all-bastion.id}"]
  user_data        = base64encode(local.bastion-userdata)
  
}


resource "aws_autoscaling_group" "bastion_eks_autoscaling" {
  name                  = "bastion_eks_autoscaling"
  vpc_zone_identifier   = ["${aws_subnet.sampleprivatecluster-worker-public-1.id}", "${aws_subnet.sampleprivatecluster-worker-public-2.id}", "${aws_subnet.sampleprivatecluster-worker-public-3.id}"]
  launch_configuration  = "${aws_launch_configuration.eksbastion-launchconfig.name}"
  min_size                   = 1
  max_size                   = 1
  health_check_grace_period  = 300
  health_check_type          = "EC2"
  force_delete               = true
  
  tag {
    key = "Name"
	value = "eksbastion-instance"
	propagate_at_launch  = true
  }
}
