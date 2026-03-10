{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    easyeffects
    komikku
    mangayomi
    # discordo
    # spotifycli
  ];
}
