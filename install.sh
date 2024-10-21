#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a package is installed
package_installed() {
    dpkg -s "$1" >/dev/null 2>&1
}

# Function to add a line to a file if it doesn't exist
add_line_to_file() {
    grep -qF -- "$1" "$2" || echo "$1" >> "$2"
}

# Variables
NIX_USER=$(whoami)
USER_HOME="/home/$NIX_USER"
DOCKER_ARCH=$([ "$(uname -m)" = "x86_64" ] && echo "amd64" || echo "$(uname -m)")

# Update apt cache
sudo apt-get update

# Install apt dependencies
APT_PACKAGES="autoconf build-essential patch libssl-dev libyaml-dev stow clang xclip libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 uuid-dev libfontconfig-dev cifs-utils fontconfig libfontconfig-dev wireguard wireguard-tools curl git xz-utils ca-certificates"
for package in $APT_PACKAGES; do
    if ! package_installed $package; then
        sudo apt-get install -y $package
    fi
done

# Create keyrings directory
sudo mkdir -p /etc/apt/keyrings

# Create dev directory
mkdir -p "$USER_HOME/dev"

# Download and store the Docker GPG key
if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi

# Add Docker repository
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    echo "deb [arch=$DOCKER_ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
fi

# Install Docker
DOCKER_PACKAGES="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
for package in $DOCKER_PACKAGES; do
    if ! package_installed $package; then
        sudo apt-get install -y $package
    fi
done

# Ensure Docker service is started and enabled
if ! systemctl is-active --quiet docker; then
    sudo systemctl start docker
fi
if ! systemctl is-enabled --quiet docker; then
    sudo systemctl enable docker
fi

# Add user to docker group
if ! groups $NIX_USER | grep -q '\bdocker\b'; then
    sudo usermod -aG docker $NIX_USER
fi

# Create .envrc file
touch "$USER_HOME/.envrc.fish"

# Create .config directory
mkdir -p "$USER_HOME/.config"

stow .

if ! command_exists nix; then
    echo "Nix is not installed. Would you like to install it? (y/n)"
    read -r install_nix
    if [[ $install_nix =~ ^[Yy]$ ]]; then
        echo "Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install) --daemon
        
        # Source nix
        . /etc/profile.d/nix.sh
        
        echo "Nix installed successfully."
    else
        echo "Skipping Nix installation."
    fi
else
    echo "Nix is already installed."
fi


echo "Setup complete. You may need to log out and back in for some changes to take effect."
