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

    # Desktop apps (no Home Manager modules)
    qbittorrent
    kanata
    protonup-qt
    # bottles-unwrapped
    # lutris-unwrapped
  ];

  programs = {
    bat.enable = true;
    atuin = {
      enable = true;
      enableBashIntegration = true;
      daemon.enable = true;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      historyWidget.command = "";
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      icons = "auto";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    television = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  programs = {
    fastfetch.enable = true;
    ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=150"
        "--max-columns-preview"
      ];
    };
    fd = {
      enable = true;
      extraOptions = [
        "--no-ignore"
        "--absolute-path"
      ];
    };
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings.updates.auto_update = true;
    };
  };
}
