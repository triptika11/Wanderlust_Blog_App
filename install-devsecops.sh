#!/bin/bash

set -e

echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y

# ------------------------------------------------
# ✅ Java (OpenJDK 17)
# ------------------------------------------------
echo "☕ Installing OpenJDK 17..."
sudo apt install openjdk-17-jdk -y
java -version

# ------------------------------------------------
# ✅ Jenkins
# ------------------------------------------------
echo "🚀 Installing Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins --no-pager

# ------------------------------------------------
# ✅ SonarQube (via Docker)
# ------------------------------------------------
echo "📦 Installing SonarQube via Docker..."
sudo docker pull sonarqube:lts

sudo docker run -d \
  -p 9000:9000 \
  -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
  sonarqube:lts


# ------------------------------------------------
# ✅ Trivy
# ------------------------------------------------
echo "🔍 Installing Trivy..."
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.tar.gz
tar -xvf trivy_0.18.3_Linux-64bit.tar.gz
sudo mv trivy /usr/local/bin/
# Add Trivy to PATH
echo 'export PATH=$PATH:/usr/local/bin/' >> ~/.bashrc
source ~/.bashrc

# Verify installation
trivy -version

🛠 To allow Jenkins to use Docker:

chmod 777 /var/run/docker.sock
# --------------------------------------------

echo "🎉 All tools installed successfully!"
