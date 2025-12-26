{ config, pkgs, username, ... }:

{
  hardware.uinput.enable = true;

  environment.systemPackages = [ pkgs.kanata ];

  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        configFile = /home/${username}/dotfiles/kanata/kanata.kbd;
      };
    };
  };
}
