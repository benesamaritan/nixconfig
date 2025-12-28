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

  programs.niri ={
    enable = true;
    useNautilus = true;
  };
  programs.xwayland.enable = true;
  services.displayManager.sddm.enable = false;

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

# Ensure these services are enabled in your SYSTEM config (configuration.nix), not Home Manager
# services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true; # Required for Trash, USB mounting, and Online Accounts

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
    xwayland-satellite
    swaylock
    nautilus
    libsecret
    udiskie
    file-roller
    loupe
    vlc
    dgop
    fuzzel
  ];
}
