{ pkgs, inputs, username, ... }:

{
  services.displayManager.sddm.enable = false;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
    quickshell = {
      package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    };
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
