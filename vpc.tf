resource "aws_vpc" "ofekvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ofeks-vpc"
  }

  enable_dns_hostnames = true
}

resource "aws_subnet" "ofeksub1" {
  depends_on = [
    aws_vpc.ofekvpc,
  ]

  vpc_id     = "${aws_vpc.ofekvpc.id}"
  cidr_block = "10.0.1.0/24"

  availability_zone_id = "usw2-az1"

  tags = {
    Name = "public1a"
  }

  map_public_ip_on_launch = true
}

resource "aws_subnet" "ofeksub2" {
  depends_on = [
    aws_vpc.ofekvpc,
  ]

  vpc_id     = "${aws_vpc.ofekvpc.id}"
  cidr_block = "10.0.2.0/24"

  availability_zone_id = "usw2-az1"

  tags = {
    Name = "private1a"
  }
}

resource "aws_internet_gateway" "ofekigw" {
  depends_on = [
    aws_vpc.ofekvpc,
  ]

  vpc_id = "${aws_vpc.ofekvpc.id}"

  tags = {
    Name = "ofekigw"
  }
}

resource "aws_route_table" "ofekrt" {
  depends_on = [
    aws_vpc.ofekvpc,
    aws_internet_gateway.ofekigw,
  ]

  vpc_id = "${aws_vpc.ofekvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ofekigw.id}"
  }

  tags = {
    Name = "ofekrt"
  }
}

resource "aws_route_table_association" "associateRouteTableWithSubnet" {
  depends_on = [
    aws_subnet.ofeksub1,
    aws_route_table.ofekrt,
  ]
  subnet_id      = aws_subnet.ofeksub1.id
  route_table_id = aws_route_table.ofekrt.id
}

resource "aws_security_group" "ofeksg" {
  depends_on = [
    aws_vpc.ofekvpc,
  ]

  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = "${aws_vpc.ofekvpc.id}"

  ingress {
    description = "TCP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ofeksg"
  }
}


