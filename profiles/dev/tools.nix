{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    bruno                    # API testing tool
    # bruno-cli              # Bruno, but CLI
    lazygit
    koji                     # Interactive CLI for conventional commit
    lazyworktree             # TUI for Git worktree management
    tokei                    # Count LoC
    glow                     # Render MD on terminal
    zed-editor
    lazysql
    dbeaver-bin
    marksman                 # Markdown LSP
    taplo                    # TOML, and Cross-Config LSP
    lua-language-server
    tealdeer                 # Man Pages in a nutshell
    television               # TUI for fzf
    disktui                  # Disk utility
    ncdu                     # Disk usage analyzer
    lazyjournal              # Journalctl TUI
    systemd-manager-tui      # Systemd manager
    navi                     # Cheatsheets
    ttyper
    starship
    helix
    yazi                     # File Manager for terminal
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(atuin init bash)"
      eval "$(starship init bash)"
      source "$(blesh-share)/ble.sh"
    '';
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
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

  programs.git-worktree-switcher.enable = true;
}
