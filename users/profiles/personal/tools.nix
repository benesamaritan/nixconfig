{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fastfetch                   # unixporn SS masterace
    pipes-rs                    # Pipes Screensaver like on Classic Windows (Rust rewrite variant)
    cmatrix                     # Matrix-like Screensaver
    television                  # TUI for fzf
    disktui                     # Disk utility
    ncdu                        # Disk usage analyzer
    navi                        # Cheatsheets
    starship
    ttyper
    qbittorrent
    kanata
    kdePackages.kdeconnect-kde
    protonup-qt
    # bottles-unwrapped
    # lutris-unwrapped
  ];

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
    settings.updates.auto_update = true;
  };

  programs.fd.enable = true;
  programs.bat.enable = true;
  programs.atuin.enable = true;

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=150"
      "--max-columns-preview"
    ];
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    historyWidget.command = "";
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
