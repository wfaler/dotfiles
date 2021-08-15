curl -L https://nixos.org/nix/install | sh
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

curl -L https://gist.githubusercontent.com/wfaler/a78acb0d0a823ce57e91063e88e48264/raw/0f52b5ca75e4711718ea371fc02d5833284694e8/home.nix --output $HOME/.config/nixpkgs/home.nix
home-manager switch
