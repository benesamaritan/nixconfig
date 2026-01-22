{ pkgs, inputs, username, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  programs.niri.enable = true;
  programs.xwayland.enable = true;
  #services.displayManager.sddm.enable = false;

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

  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    gnome-keyring
    udiskie
    cliphist
    wl-clipboard
    wl-screenrec
    pavucontrol
    grim
    slurp
    # libsecret
    # pam
    # jemalloc
    # cmake
    # pkg-config
    # cli11
    # loupe
    # file-roller
    # nemo
    # nemo-fileroller
    # nemo-preview
    # nemo-qml-plugin-dbus
    libsForQt5.qt5ct
    kdePackages.qt6ct
    # qt6ct-kde
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kio-extras-kf5
    kdePackages.ark
    inputs.wooz.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nsticky.packages.${pkgs.stdenv.hostPlatform.system}.nsticky
  ];

  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
    # QT_QPA_PLATFORMTHEME = "gtk3";
    # QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      # xdg-desktop-portal
      # xdg-desktop-portal-luminous
      # xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    # config.common.default = "*";
  };
}
