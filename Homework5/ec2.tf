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
  instance_type = var.instance_type
  subnet_id = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_tls_hw.id]
  user_data = file("apache-U.sh")
  
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
    instance_type = var.instance_type
    #availability_zone = data.aws_availability_zones.az.names[count.index]
    subnet_id = aws_subnet.main2.id
    vpc_security_group_ids = [aws_security_group.allow_tls_hw.id]
    user_data = file("apache-L.sh")
    
}
output ec2-2 {
  value = aws_instance.web1.public_ip
}