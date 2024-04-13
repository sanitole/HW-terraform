data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = var.create_instance[0].ec2_type
  subnet_id = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_tls_hw.id]
  user_data = file("apache-U.sh")
  user_data_replace_on_change = true
  
  tags = {
        Name = var.create_instance[0].ec2_name
    }

}
output ec2 {
  value       = aws_instance.web.public_ip
}

data "aws_ami" "amazon-linux-2" {
    most_recent = true
    
    filter {
      name   = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }

    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

  owners = ["amazon"] 
}

# data "aws_availability_zones" "az" {
#     state = "available"
# }

resource "aws_instance" "web1" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.create_instance[1].ec2_type
  #availability_zone = data.aws_availability_zones.az.names[count.index]
  subnet_id = aws_subnet.main2.id
  vpc_security_group_ids = [aws_security_group.allow_tls_hw.id]
  user_data = file("apache-L.sh")
  user_data_replace_on_change = true

  tags = {
    Name = var.create_instance[1].ec2_name 
  }
}
output ec2-2 {
  value = aws_instance.web1.public_ip
}