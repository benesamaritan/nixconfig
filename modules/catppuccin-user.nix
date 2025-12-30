{ pkgs, inputs, lib, ... }:
{
  imports = [ 
    inputs.catppuccin.homeModules.catppuccin 
  ];

  nix.package = pkgs.nix;

  catppuccin = {
    flavor = "mocha";
    accent = "pink";

    cache.enable = true;
    cursors.enable = true;
    atuin.enable = true;
    bat.enable = true;
    btop.enable = true;
    cava.enable = true;
    fish.enable = true;
    fzf.enable = true;
    eza.enable = true;
    dunst.enable = true;
    #chromium.enable = true;
    firefox.enable = true;
    mangohud.enable = true;
    obs.enable = true;
    lazygit.enable = true;
    swaylock.enable = true;
    thunderbird.enable = true;
    gtk.icon.enable = true;
  };

  home.activation.installSteamSkin = lib.hm.dag.entryAfter ["writeBoundary"] ''
  if [ -d "$HOME/.local/share/Steam" ]; then
     ${pkgs.adwsteamgtk}/bin/adwaita-steam-gtk -c catppuccin-mocha -i || true
  fi
'';
}
