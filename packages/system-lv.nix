{ pkgs, inputs, ... }:

{
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true;
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
  programs.partition-manager.enable = true;
  programs.gnupg.agent.enable = true;
  security.polkit.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    }]; # This and
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    }]; # |-this is for kdeconnect remote input
  };
}
