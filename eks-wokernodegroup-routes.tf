# route tables
resource "aws_route_table" "sampleprivatecluster-worker-public" {
  vpc_id = "${aws_vpc.sampleprivatecluster.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sampleprivatecluster_ig.id}"
  }

  tags = {
    Name = "sampleprivatecluster-worker-public-1"
  }
}


# route associations public
resource "aws_route_table_association" "sampleprivatecluster-worker-public-1-a" {
  subnet_id      = "${aws_subnet.sampleprivatecluster-worker-public-1.id}"
  route_table_id = "${aws_route_table.sampleprivatecluster-worker-public.id}"
}

resource "aws_route_table_association" "sampleprivatecluster-worker-public-2-a" {
  subnet_id      = "${aws_subnet.sampleprivatecluster-worker-public-2.id}"
  route_table_id = "${aws_route_table.sampleprivatecluster-worker-public.id}"
}

resource "aws_route_table_association" "sampleprivatecluster-worker-public-3-a" {
  subnet_id      = "${aws_subnet.sampleprivatecluster-worker-public-3.id}"
  route_table_id = "${aws_route_table.sampleprivatecluster-worker-public.id}"
}

# route associations private
resource "aws_route_table_association" "sampleprivatecluster-worker-private-1-a" {
  subnet_id      = "${aws_subnet.sampleprivatecluster-worker-private-1.id}"
  route_table_id = "${aws_route_table.nat_gateway_rt-1.id}"
}

resource "aws_route_table_association" "sampleprivatecluster-worker-private-2-b" {
  subnet_id      = "${aws_subnet.sampleprivatecluster-worker-private-2.id}"
  route_table_id = "${aws_route_table.nat_gateway_rt-1.id}"
}

resource "aws_route_table_association" "sampleprivatecluster-worker-private-3-c" {
  subnet_id      = "${aws_subnet.sampleprivatecluster-worker-private-3.id}"
  route_table_id = "${aws_route_table.nat_gateway_rt-1.id}"
}
