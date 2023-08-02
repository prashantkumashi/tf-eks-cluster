data "aws_ssm_parameter" "eksami" {
  name=format("/aws/service/eks/optimized-ami/%s/amazon-linux-2/recommended/image_id", aws_eks_cluster.sampleprivatecluster.version)
}


resource "aws_launch_template" "lt-ng1" {
  instance_type           = "t3.medium"
  key_name             = "${var.ami_key_pair_name}"
  name                    = format("at-lt-%s-ng1", aws_eks_cluster.sampleprivatecluster.name)
  tags                    = {}
  image_id                = data.aws_ssm_parameter.eksami.value
  user_data            = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids  = ["${aws_security_group.allnodes-sg.id}"] 
#  network_interfaces {
#    associate_public_ip_address = false
#	security_groups = ["${aws_security_group.allnodes-sg.id}"] 
#  }
  tag_specifications { 
        resource_type = "instance"
    tags = {
        Name = format("%s-ng1", aws_eks_cluster.sampleprivatecluster.name)
        }
    }
  lifecycle {
    create_before_destroy=true
  }
}
