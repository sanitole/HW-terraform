variable "region" {
    description = "AWS region"
    type = string
    default = ""
}
# variable "ami_id" {
#     description = "ami id"
#     type = string
#     default = ""
# }
variable "instance_type" {
    description = "Instance type"
    type = string
}
# variable "az" {
#     description = "AZ to start the instance"
#     type = string
#     default = ""
# }
# variable "security_groups" {
#   description = "A list of security group IDs to associate with"
#   type        = string
#   default     = ""
# }
variable "server_ports" {
    description = "A list of port range"
    type = list(object({
        range = string
        port_name = string
    }))
}
variable "vpc_cidr" {
    description = "Provide a vpc cidr block"
    type = string
}
variable "enable_dns_support" {
    type = bool
    default = true
}
variable "enable_dns_hostnames" {
    type = bool
    default = true
}
variable subnet_cidr {
    description = "Provide a subnet cidr block"
    type = list(object({
        cidr = string
        subnet_name = string
    }))
}
variable ip_on_launch {
    type = bool
    default = true
}

  