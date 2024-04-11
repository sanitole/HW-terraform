# HW-terraform
We can define variable files called *.tfvars to create a reusable file for all the variables for a project. The following is an example that covers all of the required variables to run. File allows you to externalize your variable definitions and makes it easier to manage them.

region             = "us-east-2"
ami_id             = "ami-0900f..."
availability_zone  = "us-east-2b"
instance_type      = "t2.micro"
key_name           = "my-key"
security_group_name = "my-security-group"
subnet_id          = "subnet-059b..."
server_port_range  = [22, 80, 443]
count              = 1 # how many instances to be created

Assigning a command through the command line
terraform apply -var-file anyname.tfvars or =anyname.tfvars
after run 
terraform destroy -var-file anyname.tfvars or =anyname.tfvars



