# HW-terraform
## WordPress with RDS
## Create main.tf and input following:
```hcl
module "vpc" {
    source = "sanitole/"
    version = ""
    region   = "us-east-2"
    key_name = "Bastion-key"
    ec2_name = "group-3" 
    ec2_type = "t2.micro"
    vpc_name = "group-3"
    vpc_cidr          = "10.0.0.0/16"
    subnet1_cidr = "10.0.1.0/24"
    subnet2_cidr = "10.0.2.0/24" 
    subnet3_cidr = "10.0.3.0/24"
    database_details = {   # input your data
        instance_class    = "db.t3.micro"
        allocated_storage = "Storage in GB"
        engine            = "mysql, postgresql"
        engine_version    = "Version for MySQL"
        username          = "Username for DB access"
        password          = "Password for DB access"
        db_name           = "Database name"
}
    server_ports = [
        { from_port = 22, to_port = 22 },
        { from_port = 80, to_port = 80 },
        { from_port = 3306, to_port = 3306 },
        { from_port = 443, to_port = 443 }
    ]
}
```
## Create EC2 instance, install WordPress(wordpress.sh):
```hcl
 #!/bin/bash
 
sudo yum update -y
sudo yum install -y httpd php php-mysqlnd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo cp -r wordpress/* .
sudo rm -rf wordpress latest.tar.gz
```
## Create RDS and connect to Wordpress
## Manually create S3 bucket with unique name "any_name" and store your state file in a remote backend, you can also lock your state file by using DynamoDB table.

```hcl
terraform {
  backend "s3" {
    bucket = "group-3-project"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
    #dynamodb_table = "lock-state"
  }
}
```