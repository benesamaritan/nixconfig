{ pkgs, hostname, ... }:

{
  programs.nano.enable = false;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true;
  
  environment.systemPackages = with pkgs; [
    wget
    curl
    aria2
    nixd      # Nix LSP
    nixdoc    # Generate Docs for Nix Func    
    papirus-icon-theme
  ];

  services.trilium-server = {
    enable = true;
    instanceName = "${hostname}";
    port = 25099;
    dataDir = "/var/lib/trilium-${hostname}";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25099 ];                                 # For Trilium
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];      # This and
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];      # |-this is for kdeconnect remote input
  };
}
