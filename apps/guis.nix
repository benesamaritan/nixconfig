{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunderbird
    keepassxc
    logseq
    trilium-desktop
    # gnome-feeds
    # kdePackages.alligator
    # kdePackages.akregator
    rssguard     # rss reader
    easyeffects
    haruna
    quick-webapps
    # vlc    
  ];

  programs.zen-browser.enable = true;
}
