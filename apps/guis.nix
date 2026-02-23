{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunderbird
    logseq
    trilium-desktop
    # rssguard     # rss reader
    easyeffects
    haruna
    # quick-webapps
  ];
}
