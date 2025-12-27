{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.fd.enable = true;

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };


  home.packages = with pkgs; [
    wl-clipboard

    unzip
    gzip
    gnutar

    lazygit
    imagemagick
    ghostscript
    luarocks
    tree-sitter
  ];
}
