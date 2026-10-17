{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    papirus-icon-theme
  ];

  programs = {
    bash = {
      enableCompletion = true;
      initExtra = ''
        eval "$(atuin init bash)"
        eval "$(starship init bash)"
        export GPG_TTY=$(tty)
      '';
    };
    direnv = {
      silent = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };
    devenv.enableBashIntegration = true;
    nh.clean.enable = true;
    nix-index.enableBashIntegration = true;
    nix-index-database.comma.enable = true;
    yazi.shellWrapperName = "y";
    lazygit.enable = true;
    lazysql.enable = true;
    fastfetch.enable = true;
  };
}
