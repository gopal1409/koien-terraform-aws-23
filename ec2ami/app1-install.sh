#! /bin/bash
sudo yum update -y 
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo echo "welcome to our test page" > /var/www/html/index.html