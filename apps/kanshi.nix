
{ config, pkgs, ... }:

{ 
  environment.systemPackages = [ pkgs.kanshi ];

  services.kanata.enable = true;
}

