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
    zip
    unzip
    rar
    unrar

    vscodium
    chromium
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };


  environment.pathsToLink = [ "/share/bash-completion" ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
