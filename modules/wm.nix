{ config, pkgs, inputs, ... }:

{
  imports = [ 
    #inputs.mango.hmModules.mango
    #inputs.niri.nixosModules.niri
  ];
  
  user.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    pavucontrol
    wl-clipboard
    wlr-randr
    swaybg
    wofi
    kanshi
    foot
  ];

  #programs.mango.enable = true;

  programs.niri.enable = true;
}
