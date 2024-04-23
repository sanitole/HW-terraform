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

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.create_instance[0].ec2_type
  subnet_id = aws_subnet.main2.id
  vpc_security_group_ids = [aws_security_group.group-4.id]
  user_data = file("apache.sh")
  user_data_replace_on_change = true

  tags = {
    Name = var.create_instance[0].ec2_name 
  }
}
output ec2-1 {
  value = aws_instance.web.public_ip
}

resource "aws_instance" "web2" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.create_instance[1].ec2_type
  subnet_id = aws_subnet.main3.id
  vpc_security_group_ids = [aws_security_group.group-4.id]
  user_data = file("apache.sh")
  user_data_replace_on_change = true

  tags = {
    Name = var.create_instance[1].ec2_name 
  }
}
output ec2-2 {
  value = aws_instance.web2.public_ip
}