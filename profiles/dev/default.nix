{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  files = builtins.attrNames (builtins.readDir ./.);
  imports' = builtins.filter (
    f:
    f != "default.nix"
    && lib.hasSuffix ".nix" f
    && f != "go.nix"
    && f != "js.nix"
    && f != "php.nix"
    && f != "nix.nix"
  ) files;
in

{
  imports = map (f: ./. + "/${f}") imports';

  home.packages = with pkgs; [
    (blesh.overrideAttrs {
      version = "nightly-20251019+2f564e6";
      src = fetchzip {
        url = "https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly-20251019+2f564e6.tar.xz";
        sha256 = "sha256-fpNorzJcKs1vVhaYKgRz5vcs6jsEvdxe3N4F2L81Rc0=";
      };
    })
  ];
  home.sessionPath = [
    "$HOME/.local/share/bun/bin"
  ];
  home.shellAliases = {
    x = "hx .";
    yz = "yazi";
    lzg = "lazygit";
    lzd = "lazydocker";
    lzs = "lazysql";
    lzn = "lazynpm";
    lzw = "lazyworktree";
    lzj = "lazyjournal";
    gem = "gemini";
    oc = "opencode";
    dp = "dolphin .";
    dx = "devbox";
    dv = "devenv";
  };
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
    CARGO_HOME = "$HOME/.local/share/cargo";
    BUN_INSTALL = "$HOME/.local/share/bun";
  };
}
