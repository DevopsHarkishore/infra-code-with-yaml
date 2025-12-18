#!/bin/bash
# Update system and install nginx
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

#!/bin/bash

# Update package list
sudo apt-get update -y

# Install Python3 & dev tools
sudo apt-get install -y python3 python3-dev

# Install pip
sudo apt-get install -y python3-pip

# Install venv
sudo apt-get install -y python3-venv
