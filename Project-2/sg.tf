resource "aws_security_group" "group-2" {
  name        = "group-2"
  description = "Allow inbound traffic range 22,80,9090"
  vpc_id      = aws_vpc.main.id

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