{
  lib,
  pkgs,
  inputs,
  username,
  ...
}:

{
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };

  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    # gnome-keyring
    # udiskie
    # wl-clipboard
    # wl-screenrec
    # pavucontrol
    # grim
    # slurp
    kdePackages.dolphin
    kdePackages.ark
    qimgv
    haruna
    # p7zip
    zip
    unzip
    rar
    unrar
    inputs.wooz.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nsticky.packages.${pkgs.stdenv.hostPlatform.system}.nsticky
  ];

  programs.partition-manager.enable = true;
  programs.gnupg.agent.enable = true;
  security.polkit.enable = true;

  environment = {
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      XDG_CURRENT_DESKTOP = "niri";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
    etc."xdg/menus/applications.menu" = {
      source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-termfilechooser
      # xdg-desktop-portal-gtk
      # xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
  };

  programs.dconf = {
    enable = true;
    profiles.${username}.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          gtk-theme = "Breeze-Dark";
          color-scheme = "prefer-dark";
        };
      };
    }];
  };

  qt = {
    enable = true;
    style = "breeze";
  };
}
