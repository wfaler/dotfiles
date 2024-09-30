#!/bin/bash

# Update system first
yay -Syu --noconfirm

# List of packages to install
packages=(
    btop
    darktable
    curl
    evince
    neovim
    nvidia-inst
    ripgrep
    signal-desktop
    rustup
    zellij
    zoom
    zsh
    stow
    docker
    docker-buildx
    docker-compose
    1password
    oh-my-zsh-git
    # maestral  # Uncomment if needed
    nerdfetch
    ttf-mononoki
    slack-desktop
    mise
    spotify
    direnv
    jq
    yq
    wget
    cargo-nextest
    git-secret
    gnupg
    cloc
    kubectl
    kubectx
    helm
    discord
    calibre
    google-chrome
    obs-studio
    obsidian
    whatsie
    todoist-appimage
    bruno
    evolution
    audacity
    protonmail-bridge
    proton-vpn-gtk-app
)

is_installed() {
    pacman -Qi "$1" &> /dev/null
}

fail_log="install_fail.txt"

# Clear the fail log if it exists
> "$fail_log"

# Install packages if not already installed
for package in "${packages[@]}"; do
    if ! is_installed "$package"; then
        echo "Installing $package..."
        if ! yay -S --noconfirm "$package"; then
            echo "Failed to install $package. Logging and continuing..."
            echo "$package" >> "$fail_log"
        fi
    else
        echo "$package is already installed. Skipping."
    fi
done

# Remove unnecessary dependencies
yay -Yc --noconfirm

# Install Rust stable toolchain if rustup is installed
if is_installed "rustup"; then
    if rustup install stable && rustup default stable; then
        echo "Rust stable toolchain installed and set as default."
    else
        echo "Failed to install Rust stable toolchain. Logging and continuing..."
        echo "rustup_stable_toolchain" >> "$fail_log"
    fi
else
    echo "rustup is not installed. Skipping Rust toolchain installation."
fi

# Install Alacritty last
if ! is_installed "alacritty"; then
    echo "Installing Alacritty..."
    if ! yay -S --noconfirm alacritty; then
        echo "Failed to install Alacritty. Logging and continuing..."
        echo "alacritty" >> "$fail_log"
    fi
else
    echo "Alacritty is already installed. Skipping."
fi

echo "All packages have been checked/installed. Unnecessary dependencies have been removed."

if [ -s "$fail_log" ]; then
    echo "Some installations failed. Check $fail_log for details."
else
    echo "All installations completed successfully."
    rm "$fail_log"
fi
