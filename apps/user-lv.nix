{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    thunderbird
    anytype
  ];
}
