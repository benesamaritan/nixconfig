{ lib, pkgs, inputs, username, ... }:

{
  programs.niri.enable = true;
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
    inputs.wooz.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nsticky.packages.${pkgs.stdenv.hostPlatform.system}.nsticky
  ];

  environment = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
    etc."xdg/menus/applications.menu" = {
      source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
    wlr.enable = false;
  };

  # dconf = {
  #   settings = {
  #     "org/gnome/desktop/interface" = {
  #         gtk-theme = "Breeze-Dark";
  #         color-scheme = "prefer-dark";
  #     };
  #   };
  # };

  programs.dconf = {
    enable = true;
    profiles = {
      ${username}.databases = [
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
  };

  # gtk = {
  #   # enable = true;
  #   theme = {
  #     name = "Breeze-Dark";
  #     package = pkgs.kdePackages.breeze-gtk;
  #   };
  #   gtk2.force = true;
  # };

  gtk.iconCache.enable = true;

  # qt = {
  #   enable = true;
  #   platformTheme = lib.mkDefault "gnome";
  #   style = "adwaita-dark";
  #   # style = {
  #   #   package = pkgs.kdePackages.breeze;
  #   # };
  # };
}
