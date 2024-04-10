provider aws {
    region = "us-west-2"
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

data "aws_availability_zones" "az" {
    state = "available"
}

resource "aws_instance" "web" {
    ami           = data.aws_ami.amazon-linux-2.id
    instance_type = var.instance_type
    #availability_zone = "us-west-2a"
    #availability_zone = data.aws_availability_zones.available.instance
    availability_zone = data.aws_availability_zones.az.names[count.index]
    #subnet_id = "subnet-0c7b246032e31379e"
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    key_name = aws_key_pair.deployer.key_name
    count = 3
    user_data = file("apache.sh")
    user_data_replace_on_change = true
    
    tags = {
        Name = "web- ${count.index + 1}"
    }

}

output ec2-2 {
  description = "IPs of EC2 instances"
  value = aws_instance.web[*].public_ip
}
