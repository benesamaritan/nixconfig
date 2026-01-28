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
      # ./wm.nix  # Commented: Old WM config, replaced by niri
      ./secrets.nix
    ];
}
