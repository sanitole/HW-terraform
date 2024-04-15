# HW-terraform
Manually create S3 bucket in AWS S3 simple storage, provide any unique name. Create 4 tfvars files in each region and using terraform workspace, lock and store them in your S3 bucket. Automate process with Makefile and make sure that your files are locked using your local terminal, try to run terraform apply -var-file anyname.tfvars, message above will appear. 

------Error: Error acquiring the state lock
│ 
│ Error message: operation error DynamoDB: PutItem, https response error
│ StatusCode: 400, RequestID:
│ FGH1KG68TV1FMJ85O9KQEUDUNBVV4KQNSO5AEMVJF66Q9ASUAAJG,
│ ConditionalCheckFailedException: The conditional request failed
│ Lock Info:
│   ID:        
│   Path:      
│   Operation: 
│   Who:       
│   Version:   1.7.5
│   Created:   2024-04-15 23:30:01.793672461 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.