resource "aws_security_group" "group-3" {
  name        = "group-3"
  description = "Allow inbound traffic range 22,80,443,3306"
  vpc_id      = aws_vpc.group-3.id

  dynamic "ingress" {

    for_each = var.server_ports
    content {
      description = "TLS from VPC"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}