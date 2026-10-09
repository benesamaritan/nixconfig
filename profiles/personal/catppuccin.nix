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
    # Starship prompt is hand-maintained in dotfiles (devbox segment, custom
    # palette) — keep catppuccin from generating starship.toml so the
    # out-of-store link in home.nix applies without collision.
    starship.enable = false;
    enableReleaseCheck = true;
    cursors = {
      enable = true;
      accent = "pink";
    };
  };
  home.pointerCursor.enable = true;
}
