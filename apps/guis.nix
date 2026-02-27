{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunderbird
    logseq
    trilium-desktop
    bitwarden-desktop
    komikku
    oneanime
    # rssguard     # rss reader
    easyeffects
    haruna
    # quick-webapps
  ];
}
