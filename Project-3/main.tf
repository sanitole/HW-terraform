provider "aws" {
  region = var.region
}
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = var.key_name
    Team = "Group-3"
    Env  = "Dev"
  }
}
resource "aws_vpc" "group-3" {
  cidr_block = var.vpc_details[0].vpc_cidr

  tags = {
    Name = var.vpc_details[0].vpc_name
  }
}
resource "aws_subnet" "wordpress_subnet" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.group-3.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "${each.key}-subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.group-3.id

  tags = {
    Name = var.igw_name
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.group-3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.rt_name
  }
}
resource "aws_route_table_association" "a" {
  for_each       = aws_subnet.wordpress_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}

#RDS instance  
resource "aws_db_instance" "wordpress_db" {
  allocated_storage      = var.database_details.allocated_storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.database_details.instance_class
  identifier             = "wordpressdb"
  username               = var.database_details.username
  password               = var.database_details.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.group-3.id]
  skip_final_snapshot    = true // Required to destroy
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "my-db-subnet-group"
  subnet_ids = values(aws_subnet.wordpress_subnet).*.id
}

#Subdomain
resource "aws_route53_record" "subdomain" {
  zone_id = "Z07970181H2VQB1OTJQKD" // Replace with your hosted zone ID
  name    = "awsglob.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.group-3.public_ip] // Replace with the IP address of your web server
}