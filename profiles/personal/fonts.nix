{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    inter
    liberation_ttf
    noto-fonts
    nerd-fonts.symbols-only
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term-slab
  ];
}
