# HW-terraform

```hcl
region   = "us-east-2"
key_name = "Bastion-key"
create_instance = [
  { ec2_name = "blue-group-4", ec2_type = "t2.micro" },
  { ec2_name = "green-group-4", ec2_type = "t2.micro" }
]
vpc_details = [{
  vpc_cidr             = "10.0.0.0/16",
  enable_dns_support   = true,
  enable_dns_hostnames = true,
  vpc_name = "group-4"
}]
ip_on_launch = true
subnet_cidr = [
  { cidr = "10.0.1.0/24", subnet_name = "group4_subnet1", av_zone = "us-east-2a" },
  { cidr = "10.0.2.0/24", subnet_name = "group4_subnet2", av_zone = "us-east-2b" },
  { cidr = "10.0.3.0/24", subnet_name = "group4_subnet3", av_zone = "us-east-2c" }
]
server_ports = [
  { range = "22", port_name = "SSH" },
  { range = "80", port_name = "HTTP" },
  { range = "443", port_name = "HTTPS" }
]
igw_name = "group-4-igw"
rt_name  = "group-4-rt"
lb_details = [{
  lb_name = "blue-green-deployment",
  lb_listener_port = "80",
  lb_listener_protocol = "HTTP"  
}]
lb_target_group = [
  { lb_tg_name = "blue-tg-lb", lb_tg_port = "80", lb_tg_protocol = "HTTP" },
  { lb_tg_name = "green-tg-lb", lb_tg_port = "80", lb_tg_protocol = "HTTP" }
]
enable_blue_env = true
enable_green_env = false
```