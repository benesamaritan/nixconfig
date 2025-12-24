{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        configFile = ./../config-files/kanata/kanata.kbd;

        # Or you could dump kanata.kbd into
        # config = ''
        #   (defsrc caps a s d f)
        #   (defalias escctrl (tap-hold 100 100 esc lctl))
        #   (deflayer base @escctrl a s d f)
        # '';
      };
    };
  };
  environment.systemPackages = [ pkgs.kanata ];
}
