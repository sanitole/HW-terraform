provider "aws" {
    region = var.region 
}

variable "region" {
    type = string 
}
variable "instance_type" {
     type = string
}
variable "server_ports" {
    description = "A list of port range"
    type = list(number)
    default = ["22", "80", "443"]
}

resource "aws_key_pair" "deployer" {
  key_name   = "Hm-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

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
  owners = ["099720109477"] 
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls_hw.id]
  key_name = aws_key_pair.deployer.key_name
  user_data = file("apache.sh")
  user_data_replace_on_change = true
}
output ec2 {
  value       = aws_instance.web.public_ip
}