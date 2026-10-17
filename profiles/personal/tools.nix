{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # Terminal toys (no Home Manager modules)
    pipes-rs                    # Pipes Screensaver like on Classic Windows (Rust rewrite variant)
    cmatrix                     # Matrix-like Screensaver
    ttyper
    navi                        # Cheatsheets

    # Disk utilities
    disktui                     # Disk utility
    ncdu                        # Disk usage analyzer

    # Desktop apps (no Home Manager modules; source priority:
    # nixpkgs > flake > flatpark > flathub > bun > npm — see AGENTS.md)
    qbittorrent
    kanata
    protonup-qt
    inkscape
    kdePackages.kdenlive
    google-chrome
    zoom-us
    rustdesk
    # bottles-unwrapped
    # lutris-unwrapped
  ];

  programs = {
    starship.enableBashIntegration = true;
    zoxide.enableBashIntegration = true;
    television.enableBashIntegration = true;
    bat.extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
    atuin = {
      enableBashIntegration = true;
      daemon.enable = true;
    };
    fzf = {
      enableBashIntegration = true;
      historyWidget.command = "";
    };
    eza = {
      enableBashIntegration = true;
      git = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    ripgrep.arguments = [
        "--max-columns=150"
        "--max-columns-preview"
    ];
    fd.extraOptions = [
        "--no-ignore"
        "--absolute-path"
    ];
    tealdeer = {
      enableAutoUpdates = true;
      settings.updates.auto_update = true;
    };
  };
}
