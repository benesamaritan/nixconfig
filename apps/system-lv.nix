{ config, pkgs, inputs, ... }:

{
  programs.nano.enable = false;
  programs.fish.enable = true;
  programs.virt-manager.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
    neovim
    alacritty
    vscodium
    inputs.zen-browser.packages.${pkgs.system}.beta
  ];
}
