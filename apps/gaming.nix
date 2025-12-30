{ config, pkgs, username, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
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

  users.users.${username}.extraGroups = [ "gamemode" ];

  programs.gpu-screen-recorder.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = false;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    protontricks
    dotnet-sdk
    mangohud
    lutris # be sure to disable lutris runtime
    heroic
    protonup-qt
  ];
}
