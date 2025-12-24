{ config, pkgs, inputs, ... }:

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

  hardware.graphics.enable = true;
  
#  services.displayManager.sessionPackages = [ 
#    inputs.mango.packages.${pkgs.system}.default 
#  ];

  programs.mango.enable = true;

  programs.dms-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true; 
    };
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
  };
}
