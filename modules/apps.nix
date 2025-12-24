{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tmux
    kanata
    neovim
    tmux
    alacritty
    vscodium
    mangohud
    zoxide   
    fzf
    ripgrep
    bat
    eza
    fd 
    btop
    nix-search-cli
  ];
}

