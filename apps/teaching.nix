{ pkgs, ... }:

{
  home.packages = with pkgs; [
    showmethekey 
    gromit-mpx
    obs-studio
    obs-cli
    obs-studio-plugins.obs-source-clone
    obs-studio-plugins.wlrobs
    obs-studio-plugins.obs-vnc
    obs-studio-plugins.obs-vaapi
    obs-studio-plugins.obs-teleport
    obs-studio-plugins.droidcam-obs
    obs-studio-plugins.input-overlay
    obs-studio-plugins.obs-vkcapture
    find-cursor
    #rustdesk
    lexy            # Learn X in Y minutes downloader
    asciinema       # Terminal recorder
    pom             # Pomodoro CLI
    zrok            # P2P File Sharing
    slides          # Presentation CLI Tool
  ];
}
