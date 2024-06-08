# My dotfiles
Contains my setup for:
* Neovim
* Nix Home Manager
* Alacritty
* Zsh
* Zellij

Checkout directory to home folder, then run `stow` to symlink the dotfiles to the home directory.

```bash
mkdir -p ~/.config # in case it doesn't exist, we don't want this to be a symlink.
cd dotfiles
stow .

```bash

