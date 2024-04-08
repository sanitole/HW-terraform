variable "instance_name" {
    type = list(string)
    default = ["web-1","web-2","web-3"]
}

variable "instance_count" {
    type = number
    default = "3"
}

variable "az" {
    type = list(string)
    default = ["us-west-2a","us-west-2b","us-west-2c","us-west-2d"]
}

variable "instance_type" {
    default = "t2.micro"
}