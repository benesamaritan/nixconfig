{ config, pkgs, inputs, ... }:

{
  imports = [
  #  inputs.mango.hmModules.mango
  #  inputs.dms.homeModules.dank-material-shell.niri
  #  inputs.dms.homeModules.dank-material-shell
    inputs.danksearsh.homeModules.default
  ];

  home.packages = with pkgs; [
    cliphist
    khal
    grim
    slurp
    wmenu
    dgop
    matugen
  ];

  programs.dank-material-shell = {
    enable = false;
    systemd = {
      enable = false;
      restartIfChanged = true; 
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    niri = {
      enableKeybins = true;
      enableSpawn = true;
    };
  };
  
  programs.dsearch.enable = true;
}
