{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal Emulator
    # alacritty
    wezterm

    # CLI & TUIs
    # helix-gpt
    # hx-lsp
    lynx # Web Browser for your terminal
    browsh # Web Browser for terminal (using headless firefox)
    fastfetch # unixporn SS masterace

    # Helper
    # bulletty                   # RSS Reader

    # Fun Land
    # smassh
    # typespeed
    # inputs.gittype.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.octotype.packages.${pkgs.stdenv.hostPlatform.system}.default
    pipes-rs # Pipes Screensaver like on Classic Windows (Rust rewrite variant)
    cmatrix # Matrix-like Screensaver
    # discordo                # Discord
    # spotifycli
    # inputs.gophertube.packages.${stdenv.hostPlatform.system}.default
    gophertube
  ];
}
