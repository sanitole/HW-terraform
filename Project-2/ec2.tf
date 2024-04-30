resource "aws_iam_instance_profile" "prometheus_demo" {
  name = "prometheus-demo"
  role = aws_iam_role.prometheus_demo.name
}

resource "aws_iam_role" "prometheus_demo" {
  name = "prometheus-demo"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "prometheus_demo_ingest_access" {
  role       = aws_iam_role.prometheus_demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
}

resource "aws_iam_role_policy_attachment" "prometheus_ec2_access" {
  role       = aws_iam_role.prometheus_demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
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

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.group-3.id]

  iam_instance_profile = aws_iam_instance_profile.prometheus_demo.name

  user_data = templatefile("user-d.sh.tpl",
    {
      prometheus_ver    = "2.39.1",
      node_exporter_ver = "1.4.0",
      remote_write_url  = aws_prometheus_workspace.demo.prometheus_endpoint
  })

  tags = {
    Name          = var.ec2_name
    node-exporter = "true"
  }
}

output "ec2_ip" {
  value = aws_instance.app.public_ip
}