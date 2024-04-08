provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "example" {
  bucket = "kaizen-saniya"
}
resource "aws_s3_bucket" "example2" {
  bucket_prefix = "kaizen"
}
resource "aws_s3_bucket" "example3" {
  bucket = "happy-bucket1"
  #terraform import aws_s3_bucket.example3 happy-bucket
}
resource "aws_s3_bucket" "example4" {
  bucket = "khappy-bucket2"
  #terraform import aws_s3_bucket.example4 happy-bucket2
}