{ ... }:

{	
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
