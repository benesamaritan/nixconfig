{
  lib,
  pkgs,
  username,
  inputs,
  ...
}:

{
  imports = [
    inputs.nix-gaming.nixosModules.wine
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  boot = {
    kernel.sysctl = {
      "vm.swappiness" = lib.mkDefault 10;
      "vm.max_map_count" = lib.mkDefault 2147483642;
    };
  };

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
    platformOptimizations.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    jack.enable = false;
    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    dotnet-sdk
    winetricks
    protontricks
    # mangohud          # failed to build meson and source 1st march 2026
    lutris # be sure to disable lutris runtime
    heroic
    protonup-qt
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    # (retroarch.withCores (cores: with libretro; [
    #   parallel-n64
    #   pcsx-rearmed
    #   # pcsx2
    #   ppsspp
    #   snes9x
    #   desmume
    #   # bsnes
    #   # genesis-plus-gx
    #   # flycast
    #   # dolphin
    #   # mgba
    #   # sameboy
    #   # beetle-gba
    #   # same-cdi
    # ]))
  ];
}
