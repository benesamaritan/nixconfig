{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.meslo-lg
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term-slab
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
  ];

  fonts.fontconfig.enable = true;
}
