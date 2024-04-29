resource "aws_instance" "group-3" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = var.create_instance[0].ec2_type
  associate_public_ip_address = true
  subnet_id                   = tolist(values(aws_subnet.wordpress_subnet))[0].id
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.group-3.id]
  user_data                   = file("wordpress.sh")


  tags = {
    Name = var.create_instance[0].ec2_name
  }
}