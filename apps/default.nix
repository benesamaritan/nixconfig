{ lib, pkgs, ... }:

{
	imports = [
		# ./../modules/catppuccin-user.nix
		./guis.nix
		./clis.nix
		./browser.nix
		./web-apps.nix
		# ./office.nix
		# ./graphics.nix
		# ./teaching.nix
		# ./nvim.nix
		# ./logseq.nix
		# ./tmux.nix
	];

  nix.package = pkgs.nix;

  catppuccin = {
    flavor = "mocha";
    accent = "pink";

    cache.enable        = true;
    cursors.enable      = true;
    atuin.enable        = true;
    bat.enable          = true;
    cava.enable         = true;
    fzf.enable          = true;
    eza.enable          = true;
    chromium.enable     = true;
    firefox.enable      = true;
    mangohud.enable     = true;
    obs.enable          = true;
    lazygit.enable      = true;
    swaylock.enable     = true;
    thunderbird.enable  = true;
  };

  home.activation.installSteamSkin = lib.hm.dag.entryAfter ["writeBoundary"] ''
  if [ -d "$HOME/.local/share/Steam" ]; then
     ${pkgs.adwsteamgtk}/bin/adwaita-steam-gtk -c catppuccin-mocha -i || true
  fi
'';

  home.packages = [
    pkgs.adwsteamgtk
  ];
}
