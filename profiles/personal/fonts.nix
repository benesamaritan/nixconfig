{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    inter
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    nerd-fonts.meslo-lg
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term-slab
    nerd-fonts.jetbrains-mono
  ];
}
