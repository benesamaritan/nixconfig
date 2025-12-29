{ config, pkgs, inputs, ... }:

{
  programs.nano.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
    gcc
    wget
    curl
  ];

  programs.kdeconnect.enable = true;
  programs.fish.enable = true;
  programs.virt-manager.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;

  services.flatpak.enable = true;
}
