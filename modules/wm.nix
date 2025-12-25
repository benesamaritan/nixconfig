{ config, pkgs, inputs, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config-files/${name}";
  };
in

{
  imports = [
    ./dms.nix
  ];

  programs.niri.enable = true;

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

  xdg.configFile = {
    "Kvantum"      = link "Kvantum";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };
}
