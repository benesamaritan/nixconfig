{ config, pkgs, inputs, ... }:

{
  programs.nano.enable = false;
  #services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
    gcc
    wget
    curl
  ];

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;

  programs.kdeconnect.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };
}
