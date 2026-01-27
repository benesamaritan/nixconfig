{ pkgs, inputs, ... }:

{
  programs.nano.enable = false;
  programs.fish.enable = true;
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
    inputs.trilium-notes.packages.x86_64-linux.desktop

    # Nix CLI Tools
    manix               # search nix options
    nh                  # search pkgs, alias (for nixos, home-manager, and garbage collect)
    nix-tree            # dependencies tree on nix store
    # nix-output-monitor  # pipe build command to pretty nom output | but this also used by default by nh, so
  ];

	programs.appimage = {
	  enable = true;
	  binfmt = true;
	  # package = pkgs.appimage-run.override {
	  #   extraPkgs = with pkgs; [
	  #     ffmpeg
	  #     imagemagick
	  #   ];
	  # };
	};

  # services.trilium-server = {
  #   enable = true;
  #   instanceName = "${hostname}";
  #   port = 25099;
  #   package = inputs.trilium-notes.packages.x86_64-linux.server;
  #   dataDir = "/var/lib/trilium-${hostname}";
  # };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 37840 ];                                 # For Trilium-desktop sync
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];      # This and
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];      # |-this is for kdeconnect remote input
  };
}
