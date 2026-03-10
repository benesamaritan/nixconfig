{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    bruno                    # API testing tool
    koji                     # Interactive CLI for conventional commit
    tokei                    # Count LoC
    glow                     # Render MD on terminal
    dbeaver-bin
    helix
    zed-editor

    marksman                 # Markdown LSP
    taplo                    # TOML, and Cross-Config LSP
    lua-language-server

    yazi                     # File Manager for terminal
    lazygit
    lazysql
    lazyworktree             # TUI for Git worktree management
    lazyjournal              # Journalctl TUI
    systemd-manager-tui      # Systemd manager

    (blesh.overrideAttrs {
      version = "nightly-20251019+2f564e6";
      src = fetchzip {
        url = "https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly-20251019+2f564e6.tar.xz";
        sha256 = "sha256-fpNorzJcKs1vVhaYKgRz5vcs6jsEvdxe3N4F2L81Rc0=";
      };
    })
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
