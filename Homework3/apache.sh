#!/bin/bash

sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2

echo '<h1> Hello, World! </h1></body></html>' > /var/www/html/index.html
