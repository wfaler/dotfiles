# Quick setup of my dev environment
Contains my setup for:
* Neovim
* Nix Home Manager
* Alacritty
* Zsh
* Zellij
* All dev runtimes: Node, Go, Python (with Poetry), Ruby, Rust

Checkout directory to home folder, then run `stow` to symlink the dotfiles to the home directory.

To set up a Linux machine from scratch and unstow the files:
```bash
sudo apt install autoconf patch build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
sudo apt install stow
mkdir -p ~/.config # in case it doesn't exist, we don't want this to be a symlink.

cd dotfiles
stow .
```

Setup nix and home-manager:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch
```
Setup node & python:

```bash
mise install
```

Setup neovim:
* start `nvim`
* Run `:MasonInstallAll`

