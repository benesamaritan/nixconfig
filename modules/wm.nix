{ config, pkgs, inputs, ... }:

{
  imports = [ 
    inputs.mango.hmModules.mango
    inputs.dms.homeModules.dank-material-shell
  ];

  home.packages = with pkgs; [
    swaybg
    wl-clipboard
    foot
    grim
    slurp
    wmenu
  ];
  wayland.windowManager.mango.enable = false;
}
