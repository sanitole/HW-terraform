variable "region" {
  description = "AWS region"
  type        = string
}
data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

variable "create_instance" {
  description = "EC2 name and type"
  type = list(object({
    ec2_name = string
    ec2_type = string
  }))
}
variable "server_ports" {
  description = "A list of port range"
  type = list(object({
    range     = string
    port_name = string
  }))
}
variable "vpc_general" {
  description = "Provide a vpc cidr block"
  type = list(string)
}
variable "subnet_cidr" {
  description = "Provide a subnet cidr block"
  type = list(object({
    cidr        = string
    subnet_name = string
    av_zone     = string
  }))
}
variable "ip_on_launch" {
  type    = bool
  default = true
}
variable "key_name" {
  description = "Provide a key name"
  type        = string
}
variable "igw_name" {
  type    = string
  default = ""
}
variable "rt_name" {
  type    = string
  default = ""
}
variable "lb_target_group" {
  description = "Provide a load balancer block"
  type = list(object({
    lb_tg_name     = string
    lb_tg_port     = string
    lb_tg_protocol = string
  }))
}

# variable "enable_blue_env" {
#   description = "Enable blue environment"
#   type        = bool
#   default     = true
# }
# variable "enable_green_env" {
#   description = "Enable green environment"
#   type        = bool
#   default     = true
# }


# locals {
#   traffic_dist_map = {
#     blue = {
#       blue  = 100
#       green = 0
#     }
#     blue-90 = {
#       blue  = 90
#       green = 10
#     }
#     split = {
#       blue  = 50
#       green = 50
#     }
#     green-90 = {
#       blue  = 10
#       green = 90
#     }
#     green = {
#       blue  = 0
#       green = 100
#     }
#   }
# }

# variable "traffic_distribution" {
#   description = "Levels of traffic distribution"
#   type        = string
# }
