{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports for local transfers
    dedicatedServer.openFirewall = false; # Open ports for Source Dedicated Server
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    dotnet-sdk
    mangohud
    lutris # be sure to disable lutris runtime
    protonup-qt
  ];
}
