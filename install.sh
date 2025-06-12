#!/bin/bash

echo "🚀 Starting setup: Node.js 22 + Docker + Docker Compose..."

# Update and install prerequisites
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl ca-certificates gnupg lsb-release

# -------------------------
# 📦 Install Node.js 22
# -------------------------
echo "📦 Installing Node.js 22..."

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.16.0".
nvm current # Should print "v22.16.0".

# Verify npm version:
npm -v # Should print "10.9.2".

# -------------------------
# 🐳 Install Docker Engine
# -------------------------
echo "🐳 Installing Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# -------------------------
# 🧱 Install Docker Compose (Standalone)
# -------------------------
echo "🧱 Installing Docker Compose (v2)..."
DOCKER_COMPOSE_VERSION="v2.24.7"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version

# ✅ All done
echo "✅ Setup complete! Please log out and back in for Docker group to apply."
