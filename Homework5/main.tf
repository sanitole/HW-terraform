provider "aws" {
    region = var.region
}
resource "aws_vpc" "kaizen" {
    cidr_block = var.vpc_cidr
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.kaizen.id
  cidr_block = var.subnet_cidr[0].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone = "${var.region}a"

  tags = {
    Name = var.subnet_cidr[0].subnet_name
  }
}
resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.kaizen.id
  cidr_block = var.subnet_cidr[1].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone = "${var.region}b"

  tags = {
    Name = var.subnet_cidr[1].subnet_name
  }
}
resource "aws_subnet" "main3" {
  vpc_id     = aws_vpc.kaizen.id
  cidr_block = var.subnet_cidr[2].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone = "${var.region}c"

  tags = {
    Name = var.subnet_cidr[2].subnet_name
  }
}
resource "aws_subnet" "main4" {
  vpc_id     = aws_vpc.kaizen.id
  cidr_block = var.subnet_cidr[3].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone = "${var.region}d"

  tags = {
    Name = var.subnet_cidr[3].subnet_name
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.igw_name
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.rt_name[0]
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.rt_name[1]
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.main3.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.main4.id
  route_table_id = aws_route_table.rt1.id
}