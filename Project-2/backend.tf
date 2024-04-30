terraform {
  backend "s3" {
    bucket = "group-2-project1"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
    #dynamodb_table = "lock-state"
  }
}