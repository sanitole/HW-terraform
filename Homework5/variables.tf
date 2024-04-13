variable "region" {
    description = "AWS region"
    type = string
    default = ""
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
        range = string
        port_name = string
    }))
}
variable "vpc_details" {
    description = "Provide a vpc cidr block"
    type = list(object({
        vpc_cidr = string
        enable_dns_support = bool
        enable_dns_hostnames = bool
    }))
}

variable subnet_cidr {
    description = "Provide a subnet cidr block"
    type = list(object({
        cidr = string
        subnet_name = string
        av_zone = string
    }))
}
variable ip_on_launch {
    type = bool
    default = true
}
variable "igw_name" {
    type = string
    default = ""
}
variable "rt_name" {
    type = list(string)
}