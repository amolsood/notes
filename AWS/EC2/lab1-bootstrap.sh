#!/bin/bash
## MySql
sudo apt-get update -y
sudo apt-get install -y mysql-server
sudo systemctl start mysql
## AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscli.zip"
sudo apt install unzip
unzip awscli.zip
sudo ./aws/install
aws --version
## Apache2
sudo apt-get install -y apache2
sudo systemctl start apache2