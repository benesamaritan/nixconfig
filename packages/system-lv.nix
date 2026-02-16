{ pkgs, inputs, ... }:

{
  programs.nano.enable = false;
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true;

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
      enablePureSSHTransfer = true;
    };
  };
  
  environment.systemPackages = with pkgs; [
    wget
    curl
    aria2
    nixd      # Nix LSP
    nixdoc    # Generate Docs for Nix Func    
    papirus-icon-theme
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    # agenix-cli

    # Nix CLI Tools
    manix               # search nix options
    nh                  # search pkgs, alias (for nixos, home-manager, and garbage collect)
    nix-tree            # dependencies tree on nix store
  ];

	programs.appimage = {
	  enable = true;
	  binfmt = true;
	};

  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ 37840 ];                                 # For Trilium-desktop sync
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];      # This and
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];      # |-this is for kdeconnect remote input
  };
}
