provider "aws" {
    region = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Team = "Group-4"
    Env = "Dev"
  }
}

resource "aws_vpc" "project" {
    cidr_block = var.vpc_details[1].vpc_cidr
    enable_dns_support   = var.vpc_details[2].enable_dns_support
    enable_dns_hostnames = var.vpc_details[3].enable_dns_hostnames

    tags = {
    Name = var.vpc_details[0].vpc_name
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.project.id
  cidr_block = var.subnet_cidr[0].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone = var.subnet_cidr[0].av_zone

  tags = {
    Name = var.subnet_cidr[0].subnet_name
  }
}
resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.project.id
  cidr_block = var.subnet_cidr[1].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone =  var.subnet_cidr[1].av_zone

  tags = {
    Name = var.subnet_cidr[1].subnet_name
  }
}
resource "aws_subnet" "main3" {
  vpc_id     = aws_vpc.project.id
  cidr_block = var.subnet_cidr[2].cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone =  var.subnet_cidr[2].av_zone

  tags = {
    Name = var.subnet_cidr[2].subnet_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project.id

#   tags = {
#     Name = var.igw_name
#   }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

#   tags = {
#     Name = var.rt_name[0]
#   }
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



resource "aws_lb" "external-alb" {
  name               = "External-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.group-4.id]
  subnets            = [aws_subnet.main.id, aws_subnet.main2.id, aws_subnet.main3.id]
}
resource "aws_lb_target_group" "target_elb" {
  name     = "Alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project.id
  health_check {
    path     = "/health"
    port     = 80
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group_attachment" "group-pro1" {
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = aws_instance.group-pro1.id
  port             = 80
  depends_on = [
    aws_lb_target_group.target_elb,
    aws_instance.group-pro1
  ]
}
resource "aws_lb_target_group_attachment" "group-pro2" {
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = aws_instance.group-pro2.id
  port             = 80
  depends_on = [
    aws_lb_target_group.target_elb,
    aws_instance.group-pro2
  ]
}
resource "aws_lb_listener" "listener_elb" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_elb.arn
  }
}