#!/bin/bash
set -e

# 1. Update & System Packages
sudo apt-get update -y
sudo apt-get install -y wget apt-transport-https gnupg lsb-release curl git unzip

# 2. Install Docker & Set Proper Group Permissions
sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins 2>/dev/null || true
# Note: DO NOT use chmod 666 /var/run/docker.sock (usermod group membership handles access securely)

# 3. Install Java 17
sudo apt-get install -y fontconfig openjdk-17-jre openjdk-17-jdk

# 4. Install Jenkins
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# 5. Install Trivy Scanner
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install -y trivy

# 6. Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# 7. Restart Services to Apply Group Permissions
sudo systemctl restart docker
sudo systemctl restart jenkins