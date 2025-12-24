{ pkgs, ... }: 

{
  home.packages = with pkgs; [
    inter
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.enable = true;
}
