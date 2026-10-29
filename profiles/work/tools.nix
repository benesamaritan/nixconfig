{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    gimp
    inkscape
    affinity-v3
  ];
}
