{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wfaler";
  home.homeDirectory = "/home/wfaler";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.kubectx
    pkgs.argocd
    pkgs.jq
    pkgs.yq
    pkgs.rclone
    pkgs.openssl
    pkgs.wget
    pkgs.gnumake
    pkgs.bazelisk
    pkgs.gnupg
    pkgs.hcloud
    pkgs.protobuf
    pkgs.dig
    pkgs.rustup
    pkgs.cargo-nextest
    pkgs.git
    pkgs.git-secret
    pkgs.lazygit
    pkgs.gh
    pkgs.bash
    pkgs.diffutils
    pkgs.zsh
    pkgs.fish
    pkgs.oh-my-zsh
    pkgs.cloc
    pkgs.direnv
    pkgs.ansible_2_16
    pkgs.terraform
  #  pkgs.checkov
    pkgs.zellij
    pkgs.ripgrep
    pkgs.sqlite
    pkgs.nerdfonts
    pkgs.whois
    pkgs.neovim
    pkgs.mise
    pkgs.bat
    pkgs.btop
    pkgs.yazi
    pkgs.tmux
 ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wfaler/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
