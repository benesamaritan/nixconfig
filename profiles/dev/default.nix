{ lib, pkgs, inputs, ... }:

let
  files = builtins.attrNames (builtins.readDir ./.);
  imports' = builtins.filter (
    f: f != "default.nix" && 
    lib.hasSuffix ".nix" f && 
    f != "go.nix" && 
    f != "js.nix" && 
    f != "php.nix" && 
    f != "nix.nix"
  )files;
in

{
  imports = map (f: ./. + "/${f}") imports';

  home.packages = with pkgs; [
    inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.treefmt-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    cachix
    (blesh.overrideAttrs {
      version = "nightly-20251019+2f564e6";
      src = fetchzip {
        url = "https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly-20251019+2f564e6.tar.xz";
        sha256 = "sha256-fpNorzJcKs1vVhaYKgRz5vcs6jsEvdxe3N4F2L81Rc0=";
      };
    })
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source "$(blesh-share)/ble.sh"
      eval "$(h --setup ~/repo)"
      eval "$(devbox global shellenv --init-hook)"
    '';
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };
}
