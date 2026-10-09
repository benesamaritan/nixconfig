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

    marksman                 # Markdown LSP
    taplo                    # TOML, and Cross-Config LSP
    lua-language-server

    yazi                     # File Manager for terminal
    lazygit
    lazysql

    # Nix
    manix                     # search nix options
    nix-tree                  # dependencies tree on nix store
    nix-bash-completions
    nix-health
    nil

    # Tools
    wget
    curl
    aria2
    papirus-icon-theme
    unzip
    unrar
  ];

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
