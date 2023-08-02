

# Subnets
resource "aws_subnet" "sampleprivatecluster-worker-public-1" {
  vpc_id                  = "${aws_vpc.sampleprivatecluster.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
	Name = "terraform-eks-node-public-1"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "sampleprivatecluster-worker-public-2" {
  vpc_id                  = "${aws_vpc.sampleprivatecluster.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
	Name = "terraform-eks-node-public-2"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "sampleprivatecluster-worker-public-3" {
  vpc_id                  = "${aws_vpc.sampleprivatecluster.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
	Name = "terraform-eks-node-public-3"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "sampleprivatecluster-worker-private-1" {
  vpc_id                  = "${aws_vpc.sampleprivatecluster.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
	Name = "terraform-eks-node-private-1"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

resource "aws_subnet" "sampleprivatecluster-worker-private-2" {
  vpc_id                  = "${aws_vpc.sampleprivatecluster.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
	Name = "terraform-eks-node-private-2"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

resource "aws_subnet" "sampleprivatecluster-worker-private-3" {
  vpc_id                  = "${aws_vpc.sampleprivatecluster.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
	Name = "terraform-eks-node-private-3"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}



resource "aws_route_table_association" "sampleprivatecluster-worker-private-1-nat-gw-rta"{
  subnet_id = aws_subnet.sampleprivatecluster-worker-private-1.id
  route_table_id = aws_route_table.nat_gateway_rt-1.id
}

resource "aws_route_table_association" "sampleprivatecluster-worker-private-2-nat-gw-rta"{
  subnet_id = aws_subnet.sampleprivatecluster-worker-private-2.id
  route_table_id = aws_route_table.nat_gateway_rt-1.id
  ### Comment the previous line and uncomment the line below if nat gw route is created for zone b
  #route_table_id = aws_route_table.nat_gateway_rt-2.id
  }

resource "aws_route_table_association" "sampleprivatecluster-worker-private-3-nat-gw-rta"{
  subnet_id = aws_subnet.sampleprivatecluster-worker-private-3.id
  route_table_id = aws_route_table.nat_gateway_rt-1.id
  ### Comment the previous line and uncomment the line below if nat gw route is created for zone c
  #route_table_id = aws_route_table.nat_gateway_rt-3.id
  }
