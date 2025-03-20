#!/bin/bash

echo "<<< Starting Setup >>>"

export ZDOTDIR="${HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"
mkdir -p "$XDG_CONFIG_HOME"


sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg


# --------- Install direnv ---------

echo "Installing direnv..."

sudo apt -y install direnv
command -v direnv &>/dev/null && echo "direnv installation successful!" || echo "direnv installation failed"


# --------- Install fd ---------

apt install fd-find
command -v fdfind &>/dev/null && echo "fdfind installation successful!" || echo "fdfind installation failed"
ln -s $(which fdfind) ~/.local/bin/fd


# --------- Install kubectl last version ---------

echo "Installing kubectl..."

# --- Install kubectl - apt package manager ---
if [ ! -d "/etc/apt/keyrings" ]; then
  sudo mkdir -p -m 755 /etc/apt/keyrings
fi

# Download the public signing key for the Kubernetes package repositories
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the appropriate Kubernetes apt repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

sudo apt-get update
sudo apt-get install -y kubectl

# # --- Install kubectl - binary file ---
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Check kubectl installation
if command -v kubectl &>/dev/null; then
  echo "kubectl installation successful!"
  kubectl version --client
else
  echo "kubectl installation failed"
fi


# --------- Install kubectx and kubens ---------

echo "Installing kubectx..."

sudo apt install kubectx
command -v kubectx &>/dev/null && echo "kubectx installation successful!" || echo "kubectx installation failed"


# --- Install k9s - Debian package ---

# wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.deb

# --------- Create symlinks ---------
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zshrc
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zprofile


echo "Setup completed!"