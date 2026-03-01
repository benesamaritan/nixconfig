{ pkgs, lib, ... }:
{
  nix.package = pkgs.nix;

  catppuccin = {
    flavor = "mocha";
    accent = "pink";
    enable = true;
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
