{ config, pkgs, inputs, ... }:

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
    cava
    cmatrix
    cliphist
    khal
    dgop
    matugen
    fastfetch
    nix-search-cli
    inputs.zen-browser.packages.${pkgs.system}.beta
  ];
}

