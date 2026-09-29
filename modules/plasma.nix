{
  lib,
  pkgs,
  inputs,
  username,
  ...
}:

{
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  programs.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    haruna
    qimgv
    kdePackages.kate
  ];

  programs.partition-manager.enable = true;
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
