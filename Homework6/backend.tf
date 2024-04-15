terraform {
    backend "s3" {
        bucket = "space-sushi2"
        key = "region/terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "lock-state2"
    }
}