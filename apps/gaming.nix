{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;  # Adds "Steam (Gamescope)" to display manager
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports for local transfers
    dedicatedServer.openFirewall = false; # Open ports for Source Dedicated Server
  };

  programs.gamescope.enable = true;
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;  # Lower niceness for game processes
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    dotnet-sdk
    mangohud
    lutris # be sure to disable lutris runtime
    protonup-qt
    proton-ge-bin
  ];
}
