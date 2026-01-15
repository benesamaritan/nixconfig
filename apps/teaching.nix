{ pkgs, ... }:

{
  home.packages = with pkgs; [
    showmethekey 
    gromit-mpx
    obs-studio
    find-cursor
    #rustdesk
    lexy            # Learn X in Y minutes downloader
    asciinema       # Terminal recorder
    pom             # Pomodoro CLI
    zrok            # P2P File Sharing
    slides          # Presentation CLI Tool
  ];
}
