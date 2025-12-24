{ pkgs, inputs, ... }:

{
  imports = [ inputs.dms.homeModules.dank-material-shell ];

  home.packages = [ pkgs.swww ];
}
