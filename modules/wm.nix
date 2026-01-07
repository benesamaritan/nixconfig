{ config, pkgs, inputs, username, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles/dotfiles/${name}";
  };
in

{
  imports = [
    inputs.home-manager.nixosModules.default
    #inputs.dms.nixosModules.default
    #inputs.dsearch.nixosModules.default
  ];

  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.sddm.enable = false;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  systemd.user.services.cliphist = {
    description = "Clipboard history watcher";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
      RestartSec = "3s";
    };
  };

  services.upower.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "Hibernate";
    HandleLidExternalPower = "Lock";
    HandlePowerKey = "suspend";
  };

  services.geoclue2.enable = true;

# services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true; # Required for Trash, USB mounting, and Online Accounts

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    pavucontrol
    cliphist
    wl-clipboard
    wl-screenrec
    grim
    slurp
    libsecret
    pam
    jemalloc
    cmake
    pkg-config
    cli11
    udiskie
    file-roller
    loupe
    vlc
    fastfetch
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kio-extras
    inputs.wooz.packages.${pkgs.system}.default
  ];

  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
  };
}
