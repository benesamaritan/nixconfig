{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fastfetch # unixporn SS masterace
    pipes-rs # Pipes Screensaver like on Classic Windows (Rust rewrite variant)
    cmatrix # Matrix-like Screensaver
    tealdeer # Man Pages in a nutshell
    television # TUI for fzf
    disktui # Disk utility
    ncdu # Disk usage analyzer
    navi # Cheatsheets
    starship
    ttyper
    qbittorrent
  ];
}
