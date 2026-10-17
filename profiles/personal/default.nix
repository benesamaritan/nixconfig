{ lib, ... }:

let
  entries = builtins.readDir ./.;
  isModule = name: type: type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name;
in
{
  imports = map (name: ./. + "/${name}") (builtins.attrNames (lib.filterAttrs isModule entries));
}
