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
localhost ansible_connection=local ansible_user=wfaler

[local_server:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_become=yes
ansible_become_method=sudo
nix_user=wfaler
```
Now run the playbook:
```bash
ansible-playbook -i inventory ansible/prepare.yml --ask-become-pass --ask-pass
```

Unfortunately, nix can't be installed reliabily with ansible, so you have to run the following commands manually:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install 
export NIXPKGS_ALLOW_UNFREE=1 && $HOME/.nix-profile/bin/home-manager switch
```
Now run the last playbook:
```bash
ansible-playbook -i inventory ansible/main.yml --ask-become-pass --ask-pass
```


You should now have a mostly setup dev environment.

You might now want to open up the Embellish app on the new machine, and install the Mononoki nerd fonts, and possibly JetBrains Mono.

You might also want to open neovim with `nvim` and run `:PlugInstall` to install all the plugins, followed by `:MasonInstallAll` to install all the mason plugins.

