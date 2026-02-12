{ ... }:

{	
  imports =
    [
      ./fonts.nix
      ./printing.nix
      ./catppuccin-system.nix
      ./virtualization.nix
      ./niri
      # ./desktop.nix  # Commented: Alternative desktop, not currently used
      ./secrets.nix
    ];
}
