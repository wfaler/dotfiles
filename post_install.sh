#!/bin/bash
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if ! command_exists nix; then
    echo "Nix is not installed. Please install Nix first."
    exit 1
fi

if ! command_exists home-manager; then
   nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

   nix-channel --update

   export NIXPKGS_ALLOW_UNFREE=1
   nix-shell '<home-manager>' -A install


   home-manager switch

fi


if ! grep -q "$(which fish)" /etc/shells; then
    echo "Adding fish to /etc/shells..."
    echo "$(which fish)" | sudo tee -a /etc/shells
else
    echo "Fish is already in /etc/shells."
fi

if [ "$SHELL" != "$(which fish)" ]; then
    echo "Changing default shell to fish..."
    chsh -s "$(which fish)"
else
    echo "Fish is already the default shell."
fi

mise install

echo "home-manager has been installed and configured successfully."
