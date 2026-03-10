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
    flavor = "mocha";
    accent = "pink";
    enableReleaseCheck = true;
    cache.enable = true;
    cursors.enable = true;
    gtk.icon.enable = false;
  };

  home.activation.installSteamSkin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.local/share/Steam" ]; then
       ${pkgs.adwsteamgtk}/bin/adwaita-steam-gtk -c catppuccin-mocha -i || true
    fi
  '';

  home.packages = [
    pkgs.adwsteamgtk
  ];
}
