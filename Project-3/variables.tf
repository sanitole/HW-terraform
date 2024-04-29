variable "region" {
  description = "Provide region"
  type        = string
}
variable "vpc_details" {
  description = "Provide a vpc cidr block"
  type = list(object({
    vpc_cidr = string
    vpc_name = string
  }))
}
variable "key_name" {
  description = "Provide a key name"
  type        = string
}
variable "subnets" {
  description = "A map of subnet specifications keyed by subnet name, each containing CIDR block and availability zone"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}
variable "server_ports" {
  description = "A list of port range"
  type = list(object({
    from_port = number
    to_port   = number
  }))
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
variable "igw_name" {
  type    = string
  default = ""
}
variable "rt_name" {
  type    = string
  default = ""
}
variable "database_details" {
  type = object({
    instance_class    = string # e.g., db.t3.micro
    allocated_storage = number # Storage in GB
    engine            = string # e.g., mysql, postgresql
    engine_version    = string # e.g., 5.7 for MySQL
    username          = string # Username for DB access
    password          = string # Password for DB access
    db_name           = string # Database name
  })
  description = "Configuration details for the RDS instance"
}