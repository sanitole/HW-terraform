#!/bin/bash

sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo echo "<h1> Hello, World! </h1>" >> /var/www/html/index.html