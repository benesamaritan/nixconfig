{ config, pkgs, inputs, username, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles/dotfiles/${name}";
  };
in

{
  imports = [
    #inputs.home-manager.nixosModules.default
    #inputs.dms.nixosModules.default
    #inputs.dsearch.nixosModules.default
  ];

  programs.niri.enable = true;
  programs.xwayland.enable = true;
  #services.displayManager.sddm.enable = false;

  services.displayManager = {
    dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${username}";
      # configFiles = [
      #   "/home/${username}/.config/DankMaterialShell/settings.json"
      # ];
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    autoLogin = {
      enable = false;
      user = "${username}";
    };
  };

  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableVPN = false;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;

    plugins = let
      dmsPlugins = pkgs.fetchFromGitHub {
        owner = "AvengeMedia";
        repo = "dms-plugins";
        rev = "8fa7c52";
        hash = "sha256-0RXRgUXXoX+C0q+drsShjx2rCTdmqFzOCR/1rGB/W2E=";
      };
    in {
      DankPomodoro = {
        enable = true;
        src = "${dmsPlugins}/DankPomodoro";
      };
      DankBatteryAlerts = {
        enable = true;
        src = "${dmsPlugins}/DankBatteryAlerts";
      };
      AppShortcut = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "oabragh";
          repo = "AppShortcut";
          rev = "373400a";
          hash = "sha256-Yu3zRWkkgr5mC8pzNiRlHcCCb2lDZzkWWRJsMCAJfS4=";
        };
      };
      DankNixMonitor = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "antonjah";
          repo = "nix-monitor";
          rev = "f3dbe00";
          hash = "sha256-biRc7ESKzPK5Ueus1xjVT8OXCHar3+Qi+Osv/++A+Ls=";
        };
      };
      DankNiriWindows = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "rochacbruno";
          repo = "DankNiriWindows";
          rev = "b845277";
          hash = "sha256-rdZAnkRyfycI2a2wjSiepQwRI49zKbwoRzpz1+c6ZJA=";
        };
      };
    };
  };

  programs.dsearch = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    package = inputs.dsearch.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

#  home-manager.users."${username}" = {
#    imports = [  ];
#
#    xdg.configFile = {
#      # "Kvantum" = link "Kvantum";
#    };
#  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    pavucontrol
    wl-clipboard
    wlr-randr
    kanshi
    foot
    cliphist
    khal
    grim
    slurp
    dgop
    xwayland-satellite
    swaylock
    fuzzel
  ];
}
