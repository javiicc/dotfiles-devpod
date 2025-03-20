#!/bin/bash

echo "<<< Starting Setup >>>"

export ZDOTDIR="${HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"
mkdir -p "$XDG_CONFIG_HOME"


sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg


# --- Install kubectl last version ---

echo "Installing kubectl..."

if [ ! -d "/etc/apt/keyrings" ]; then
  sudo mkdir -p -m 755 /etc/apt/keyrings
fi

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

sudo apt-get update
sudo apt-get install -y kubectl

# Check kubectl installation
if command -v kubectl &>/dev/null; then
  echo "kubectl is installed"
else
  echo "kubectl is not installed"
fi


# --- Create symlinks ---
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zshrc
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zprofile


echo "Setup completed!"