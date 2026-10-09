{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # bruno                  # API testing tool
    koji                     # Interactive CLI for conventional commit
    tokei                    # Count LoC
    glow                     # Render MD on terminal
    # dbeaver

    # Language servers (no Home Manager modules)
    marksman                 # Markdown LSP
    taplo                    # TOML, and Cross-Config LSP
    lua-language-server

    # Nix tools (no Home Manager modules)
    manix                     # search nix options
    nix-tree                  # dependencies tree on nix store
    nix-bash-completions
    nix-health
    nil                       # Nix LSP

    # Downloads and archives
    wget
    curl
    aria2
    unzip
    unrar

    # Theming assets
    papirus-icon-theme
  ];

  programs = {
    yazi = {
      enable = true;         # File Manager for terminal
      shellWrapperName = "y";
    };
    lazygit.enable = true;
    lazysql.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(atuin init bash)"
      eval "$(starship init bash)"
      export GPG_TTY=$(tty)
    '';
  };

  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };
    devenv = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    nix-index-database.comma.enable = true;
  };
}
