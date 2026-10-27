{
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
    wezterm.enable = false;
    enableReleaseCheck = true;
    cursors = {
      enable = true;
      accent = "pink";
    };
  };
  home.pointerCursor.enable = true;
}
