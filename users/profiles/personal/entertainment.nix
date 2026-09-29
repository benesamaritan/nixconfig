{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    losange
    komikku
    mangayomi
    discordo
    spotifycli
  ];
}
