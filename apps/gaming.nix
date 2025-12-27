{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode = {
    enable = true;
    enableRenice = true; 
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    protontricks
    dotnet-sdk
    mangohud
    lutris # be sure to disable lutris runtime
    protonup-qt
  ];
}
