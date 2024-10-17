#!/bin/bash

# Update system first
brew update
# List of packages to install
packages=(
    btop
    curl
    neovim
    ripgrep
    nerd-fonts
    rustup
    stow
    direnv
    jq
    yq
    clang
    wget
    cargo-nextest
    git-secret
    gnupg
    cloc
    kubectl
    kubectx
    helm
    mise
    git
    fish
    fisher
   # ## VARIOUS CLIENT APPS
   #  slack-desktop
   #  spotify
   #  evince
   #  dropbox 
   #  1password
   #  zoom
   #  obs-studio
   #  obsidian
   #  whatsie
   #  todoist-appimage
   #  bruno
   #  evolution
   #  audacity
   #  protonmail-bridge
   #  proton-vpn-gtk-app
   #  signal-desktop
   #  darktable
   #  discord
   #  calibre
   #  google-chrome
   #  brave-bin
   #  tailscale
   #  fish
   #  fisher
)

is_installed() {
  brew list "$1" &> /dev/null
}

fail_log="install_fail.txt"

# Clear the fail log if it exists
> "$fail_log"

# Install packages if not already installed
for package in "${packages[@]}"; do
    if ! is_installed "$package"; then
        echo "Installing $package..."
        if ! brew install "$package"; then
            echo "Failed to install $package. Logging and continuing..."
            echo "$package" >> "$fail_log"
        fi
    else
        echo "$package is already installed. Skipping."
    fi
done

# Remove unnecessary dependencies
brew cleanup

echo "All packages have been checked/installed. Unnecessary dependencies have been removed."

if [ -s "$fail_log" ]; then
    echo "Some installations failed. Check $fail_log for details."
else
    echo "All installations completed successfully."
    rm "$fail_log"
fi
# Inform the user about the need to log out and back in
echo "Please log out and back in for the changes to take effect."
echo "Alternatively, you can run 'newgrp docker' to apply the changes in the current shell session."

stow .
