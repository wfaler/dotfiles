# Quick setup of my dev environment
Contains my setup for:
* Neovim
* Kitty 
* Zsh
* All dev runtimes: Node, Go, Python (with Poetry), Ruby, Rust
* All the apps I use, more or less, installed via `yay` in Arch

## Setup on Arch Linux
Clone this repository and run the install script:
```bash
cd .config && ./install.sh
```
Stow all the files in the root of the repository
```bash
stow .
```

You should now have a mostly setup dev environment.

You might also want to open neovim with `nvim` and run `:Lazy install` to install all the plugins, followed by `:MasonInstallAll` to install all the mason plugins.

## Nvidia systems
Uncomment the `nvidia-inst` line of the install script.
Run `nvidia-inst` after installation, to install all the nvidia-tools

## Screensharing on Hyprland

```
systemctl --user enable pipewire
systemctl --user start pipewire
systemctl --user enable wireplumber
systemctl --user start wireplumber
systemctl --user start xdg-desktop-portal
systemctl --user start xdg-desktop-portal-hyprland
```
These instructions worker: https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
