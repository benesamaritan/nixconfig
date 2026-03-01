{
  username,
  ...
}:

{
  services.displayManager.sddm.enable = false;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
  services.upower.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "Hibernate";
    HandleLidExternalPower = "Lock";
    HandlePowerKey = "suspend";
  };

  services.geoclue2.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
}
