{ pkgs, lib, inputs, ... }:

{
  #Bagian flatpak dimanage sebagi module HM, jadi run hmsw untuk build

  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.onActivation = true;
    remotes = lib.mkOptionDefault [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    packages = [
      #"io.github.kolunmi.Bazaar"
      #"com.collaboraoffice.Office"
    ];
  };
}
