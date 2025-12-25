{ config, pkgs, username, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager = {
    defaultSession = "cinnamon-wayland";
    autoLogin = {
      enable = true;
      user = "${username}";
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
