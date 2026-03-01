{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunderbird
    logseq
    trilium-desktop
    bitwarden-desktop
    komikku
    mangayomi
    # rssguard     # rss reader
    easyeffects
    haruna
    # quick-webapps
  ];
}
