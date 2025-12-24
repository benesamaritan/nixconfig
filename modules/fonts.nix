{ pkgs, ... }: 

{
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;
}
