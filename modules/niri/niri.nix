{ lib, pkgs, inputs, username, ... }:

{
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };
  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    gnome-keyring
    udiskie
    wl-clipboard
    wl-screenrec
    pavucontrol
    grim
    slurp
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kio-extras-kf5
    kdePackages.ark
    p7zip
    zip
    unzip
    rar
    unrar
    inputs.wooz.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nsticky.packages.${pkgs.stdenv.hostPlatform.system}.nsticky
  ];

  environment = {
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
      # QT_QPA_PLATFORMTHEME = "qt6ct";
      # QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
      XDG_CURRENT_DESKTOP = "niri";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
    etc."xdg/menus/applications.menu" = {
      source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
    wlr.enable = false;
  };

  programs.dconf = {
    enable = true;
    profiles.${username}.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-theme = "Breeze-Dark";
            color-scheme = "prefer-dark";
          };
        };
      }
    ];
  };

  gtk.iconCache.enable = true;

  qt = {
    enable = true;
    platformTheme = lib.mkDefault "qt5ct";
  #   style = "adwaita-dark";
  #   # style = {
  #   #   package = pkgs.kdePackages.breeze;
  #   # };
  };
}
