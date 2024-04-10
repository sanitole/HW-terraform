#!/bin/bash

sudo yum update
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1> Hello, World! </h1>" >> /var/www/html/index.html