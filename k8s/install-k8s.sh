#!/bin/bash

set -e

echo "🔧 Installing Kubernetes CLI tools: kind, kubectl, and helm..."

# -------------------
# Install K3s cluster && Kubectl
# -------------------
sudo apt update && sudo apt upgrade -y
curl -sfL https://get.k3s.io | sh -
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
source ~/.bashrc

# Download and install kubectl
curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/
kubectl version --client


echo "k3s cluster & kubectl installation complete."


# -------------------
# Install Helm
# -------------------
echo "📦 Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
echo "✅ Helm installed: $(helm version --short)"

echo "🎉 All tools installed successfully!"
