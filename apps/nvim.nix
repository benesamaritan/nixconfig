{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    wl-clipboard

    unzip
    gzip
    gnutar

    lazygit
    imagemagick
    ghostscript
    lua
    luarocks
    tree-sitter
    #nodejs
    #python3
    #go
    #cargo
  ];
}
