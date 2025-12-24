{ config, pkgs, username, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    desktopManager.cinnamon.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${username}";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr 
    ];
    config.common.default = "*"; 
  };
}
