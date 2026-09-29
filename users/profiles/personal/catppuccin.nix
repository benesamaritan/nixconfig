{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "pink";
    enableReleaseCheck = true;
    cursors = {
      enable = true;
      accent = "pink";
    };
  };
}
