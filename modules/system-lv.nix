{ pkgs, inputs, ... }:

{
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    # Nix
    manix # search nix options
    nh # search pkgs, alias (for nixos, home-manager, and garbage collect)
    nix-tree # dependencies tree on nix store
    nixdoc # look up Nix func
    nixd # Nix LSP
    nixfmt
    nix-bash-completions
    nix-health

    # Tools
    wget
    curl
    aria2
    papirus-icon-theme
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.pathsToLink = [ "/share/bash-completion" ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
