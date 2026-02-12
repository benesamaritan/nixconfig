{ username, ... }:

{
  services.displayManager.sddm.enable = false;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
