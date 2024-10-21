#!/bin/bash
# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Nix is installed
if ! command_exists nix; then
    echo "Nix is not installed. Please install Nix first."
    exit 1
fi

# Check if home-manager is already installed
if ! command_exists home-manager; then
   nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Update channels
   nix-channel --update

# Install home-manager
   nix-shell '<home-manager>' -A install

# Export NIXPKGS_ALLOW_UNFREE
   export NIXPKGS_ALLOW_UNFREE=1

# Run home-manager switch
   home-manager switch


fi

# If we've reached this point, Nix is installed but home-manager is not

# Add home-manager channel
if ! grep -q "$(which fish)" /etc/shells; then
    echo "Adding fish to /etc/shells..."
    echo "$(which fish)" | sudo tee -a /etc/shells
else
    echo "Fish is already in /etc/shells."
fi

# Change user's default shell to fish if it's not already
if [ "$SHELL" != "$(which fish)" ]; then
    echo "Changing default shell to fish..."
    chsh -s "$(which fish)"
else
    echo "Fish is already the default shell."
fi




echo "home-manager has been installed and configured successfully."
