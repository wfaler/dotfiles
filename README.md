# Quick setup of my dev environment
Contains my setup for:
* Neovim
* Nix Home Manager
* Alacritty
* Zsh
* Zellij
* All dev runtimes: Node, Go, Python (with Poetry), Ruby, Rust
* All the apps I use, more or less

## Setup on Linux
Enable sshd on the new machine:
```bash
sudo apt update
sudo apt install openssh-server
sudo systemctl enable ssh 
sudo systemctl start ssh
```
On an existing machine, create an inventory file:
```bash
[local_server]
192.168.1.100 ansible_user=your_username

[local_server:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_become=yes
ansible_become_method=sudo
nix_user=your_username
```
Now run the playbook:
```bash
ansible-playbook -i inventory.ini ansible/main.yml --ask-pass
```
You should now have a mostly setup dev environment.

You might now want to open up the Embellish app on the new machine, and install the Mononoki nerd fonts, and possibly JetBrains Mono.

You might also want to open neovim with `nvim` and run `:PlugInstall` to install all the plugins, followed by `:MasonInstallAll` to install all the mason plugins.

## Handcrafted snowflake setup (not recommended)
Checkout directory to home folder, then run `stow` to symlink the dotfiles to the home directory.

To set up a Linux machine from scratch and unstow the files:
```bash
sudo apt install autoconf patch build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev libfontconfig-dev cifs-utils
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


