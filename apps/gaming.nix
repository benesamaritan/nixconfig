{ config, pkgs, username, ... }:

let
  retroarch-custom = pkgs.writeShellScriptBin "retroarch" ''
    mkdir -p $HOME/.config/retroarch/{cores,info,assets,system,playlists}
    exec ${pkgs.retroarch}/bin/retroarch \
      --set video_driver=vulkan \
      --set libretro_directory=$HOME/.config/retroarch/cores \
      --set libretro_info_path=$HOME/.config/retroarch/info \
      --set assets_directory=$HOME/.config/retroarch/assets \
      --set system_directory=$HOME/.config/retroarch/system \
      "$@"
  '';
in

{
  hardware.graphics = {
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
    (retroarch.withCores (cores: with libretro; [
      #snes9x
      #desmume
      #bsnes
      #genesis-plus-gx
      #flycast
      #dolphin
      #mgba
      #mupen64plus
      parallel-n64
      pcsx-rearmed
      pcsx2
      ppsspp
      #sameboy
      #beetle-gba
      #same-cdi
    ]))
  ];
}
