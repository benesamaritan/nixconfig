{ pkgs, ... }:
{
  catppuccin.gtk.icon.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Pink";
      package = pkgs.catppuccin-gtk;
    };
    gtk4.theme = {
      name = "Catppuccin-Mocha-Pink";
      package = pkgs.catppuccin-gtk;
    };
  };
}
