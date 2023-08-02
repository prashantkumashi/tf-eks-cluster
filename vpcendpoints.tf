resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.s3", var.AWS_REGION)
  route_table_ids = ["${aws_route_table.sampleprivatecluster_rt.id}"]
}

resource "aws_vpc_endpoint_route_table_association" "s3_rt_association"{
  route_table_id = "${aws_route_table.sampleprivatecluster_rt.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.ec2", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "ecrapi" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.ecr.api", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "ecrdkr" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.ecr.dkr", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.logs", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "sts" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.sts", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "elasticloadbalancing" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.elasticloadbalancing", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "autoscaling" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.autoscaling", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "appmesh-envoy-management" {
  vpc_id       = aws_vpc.sampleprivatecluster.id
  service_name = format("com.amazonaws.%s.appmesh-envoy-management", var.AWS_REGION)
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}


resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.sampleprivatecluster.id
  vpc_endpoint_type = "Interface"
  service_name = format("com.amazonaws.%s.ec2messages", var.AWS_REGION)
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

#  tags              = {}
#  timeouts {}
#  route_table_ids     = []

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.sampleprivatecluster.id
  vpc_endpoint_type = "Interface"
  service_name = format("com.amazonaws.%s.ssm", var.AWS_REGION)
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

#  tags              = {}
#  timeouts {}
#  route_table_ids     = []

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.sampleprivatecluster.id
  vpc_endpoint_type = "Interface"
  service_name = format("com.amazonaws.%s.ssmmessages", var.AWS_REGION)
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
	aws_security_group.sampleprivatecluster-cluster-sg.id,
  ]
  private_dns_enabled = true

#  tags              = {}
#  timeouts {}
#  route_table_ids     = []

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  subnet_ids = [
	aws_subnet.sampleprivatecluster-worker-private-1.id,
    aws_subnet.sampleprivatecluster-worker-private-2.id,
    aws_subnet.sampleprivatecluster-worker-private-3.id,
  ]
}
