{ pkgs, ... }:

{
  home.packages = with pkgs; [
    showmethekey 
    gromit-mpx
    obs-studio
    find-cursor
    rustdesk
  ];
}
