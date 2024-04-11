resource "aws_security_group" "allow_tls_hw" {
  name        = "allow_tls_hw"
  description = "Allow inbound traffic range 22,80,443"

    ingress {
    from_port        = var.server_ports[1]
    to_port          = var.server_ports[1]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    from_port        = var.server_ports[0]
    to_port          = var.server_ports[0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = var.server_ports[2]
    to_port          = var.server_ports[2]
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