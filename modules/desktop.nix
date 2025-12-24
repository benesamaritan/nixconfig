{ config, pkgs, username, ... }:

{
  # X Server configuration for graphical desktop environment
  services.xserver = {
    # Enable X11 windowing system required for Cinnamon desktop environment
    enable = true;
    
    # Disable LightDM display manager (using SDDM instead)
    displayManager.lightdm.enable = false;
    
    # Enable Cinnamon desktop environment - traditional desktop with taskbar, menu, and system tray
    desktopManager.cinnamon.enable = true;
  };

  # SDDM (Simple Desktop Display Manager) configuration
  services.displayManager.sddm = {
    # Enable SDDM as the login screen/display manager
    enable = true;
    
    # Enable Wayland support for modern display protocol with better performance and security
    wayland.enable = true;
  };
  
  # Auto-login configuration for seamless boot-to-desktop experience
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${username}";

  # XDG Desktop Portal configuration for cross-desktop integration
  xdg.portal = {
    # Enable desktop portal for file choosers, screen sharing, and other desktop integrations
    enable = true;
    
    # Additional portal backends for GTK and wlroots compatibility
    extraPortals = with pkgs; [
      # GTK portal for GTK-based applications
      xdg-desktop-portal-gtk
      
      # wlroots portal for Wayland compositor compatibility
      xdg-desktop-portal-wlr 
    ];
    
    # Set default portal for all desktop integrations
    config.common.default = "*"; 
  };
}
