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
    # WezTerm is hand-maintained in dotfiles (tabline, dank-theme). Left on,
    # catppuccin injects programs.wezterm.extraConfig, which makes the HM
    # module emit ~/.config/wezterm/wezterm.lua and collide with the
    # out-of-store link in users/benesamaritan/dotfiles.nix.
    wezterm.enable = false;
    enableReleaseCheck = true;
    cursors = {
      enable = true;
      accent = "pink";
    };
  };
  home.pointerCursor.enable = true;
}
