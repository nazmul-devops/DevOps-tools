#!/bin/bash

# Update the system
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Check Jenkins status
sudo systemctl status jenkins

# Configure Jenkins to run on port 8080
sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=8081/' /etc/default/jenkins

# Restart Jenkins service
sudo systemctl restart jenkins

