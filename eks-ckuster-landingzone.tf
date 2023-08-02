
resource "aws_vpc" "sampleprivatecluster" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  
  tags = {
     Name = "terraform-eks-node"
     "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

resource "aws_internet_gateway" "sampleprivatecluster_ig" {
  vpc_id = "${aws_vpc.sampleprivatecluster.id}"

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_route_table" "sampleprivatecluster_rt" {
  vpc_id = "${aws_vpc.empyern.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sampleprivatecluster_ig.id}"
  }
}





resource "aws_eip" "nat_gateway-eip"{
  vpc = true
}

#NAT GW for Zone A
resource "aws_nat_gateway" "nat_gateway-1"{
  allocation_id = aws_eip.nat_gateway-eip.id 
  subnet_id = aws_subnet.sampleprivatecluster-worker-public-1.id
  tags = {
    "Name" = "NAT_GATEWAY Zone A" 
  }
}

output "nat_gateway_ip-1" {
  value = aws_eip.nat_gateway-eip.public_ip
}

resource "aws_route_table" "nat_gateway_rt-1" {
  vpc_id = aws_vpc.sampleprivatecluster.id 
  route {
    cidr_block = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.nat_gateway-1.id
  }
}
