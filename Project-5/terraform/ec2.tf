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
  subnet_id = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name =  aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = "${self.ipv4_address}"
      type        = "ssh"
      user        = "root"
      private_key = "${file('~/.ssh/id_rsa')}"
    }
  }
  provisioner "local-exec" {
  command = "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.instance_ssh_priv_key} -e'pub_key=${var.pub_key} ../ansible/main.yml"
  } 
} 
output "ip" {
  value       = aws_instance.web.public_ip
}
