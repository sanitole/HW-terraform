resource "aws_security_group" "group-4" {
  name        = "group-4"
  description = "Allow inbound traffic range 22,80"
  vpc_id      = aws_vpc.group-4.id

  ingress {
    from_port   = var.server_ports[1].range
    to_port     = var.server_ports[1].range
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.server_ports[0].range
    to_port     = var.server_ports[0].range
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.server_ports[2].range
    to_port     = var.server_ports[2].range
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}