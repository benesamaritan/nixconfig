{ config, pkgs, username, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    desktopManager.cinnamon.enable = true;
  };

  programs.xwayland.enable = true;

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "cinnamon-wayland";
      autoLogin = {
        enable = false;
        user = "${username}";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
