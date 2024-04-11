provider "aws" {
    region = var.region
}

resource "aws_instance" "web" {
    ami           = var.ami_id
    instance_type = var.instance_type
    count = var.instance_count
    availability_zone = var.az
    subnet_id = var.subnet_id
    security_groups = [aws_security_group.allow_tls_hw.name]
    key_name = var.key_name
    
    tags = {
        Name = "Demo-hw ${var.az}"
    }
}