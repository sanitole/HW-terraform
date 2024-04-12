resource "aws_security_group" "allow_tls_hw" {
  name        = "allow_tls_hw"
  description = "Allow inbound traffic range 22,80"
  vpc_id = aws_vpc.kaizen.id

    ingress {
    from_port        = var.server_ports[1].range
    to_port          = var.server_ports[1].range
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    from_port        = var.server_ports[0].range
    to_port          = var.server_ports[0].range
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}