{ config, pkgs, inputs, hostname, ... }:

{
  programs.nano.enable = false;
  # services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
    # gcc
    wget
    curl
    nixd  # Nix LSP
    nixdoc    # Generate Docs for Nix Func    
    # inputs.trilium-notes.packages.${stdenv.hostPlatform.system}.desktop
  ];

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;

  programs.kdeconnect.enable = true;
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  #   allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  # };

  services.trilium-server = {
    enable = true;
    # noAuthentication = true;
    instanceName = "${hostname}";
  #   package = inputs.trilium-notes.packages.${stdenv.hostPlatform.system}.server;
    port = 25099;
    dataDir = "/var/lib/trilium-${hostname}";
  };
  networking.firewall.allowedTCPPorts = [ 8080 25099 ];
}
