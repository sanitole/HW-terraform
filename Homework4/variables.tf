variable "ami_id" {
    description = "ami id"
    type = string
    default = ""
}
variable "instance_type" {
    description = "Instance type"
    type = string
    default = "t2.micro"
}
variable "az" {
    description = "AZ to start the instance"
    type = string
    default = ""
}
variable "region" {
    description = "AWS region"
    type = string
    default = ""
}

variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = string
  default     = ""
}
variable "server_ports" {
    description = "A list of port range"
    type = list(number)
    default = ["22", "80", "443"]
}
variable "key_name" {
    description = "Key name of the Key Pair to use for the instance"
    type = string
    default = "my-key"
}
variable "instance_count" {
    description = "Number of insatnces to be created"
    type = number
    default = 1
}
variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}