{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inkscape
    gimp
    # inputs.affinity-nix.packages.x86_64-linux.v3
  ];
}
