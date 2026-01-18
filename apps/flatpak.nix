{ pkgs, lib, inputs, ... }:

{
  imports = [
    #inputs.nix-flatpak.nixosModules.nix-flatpak
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
      "io.github.kolunmi.Bazaar"
      #"com.collaboraoffice.Office"
    ];
    # overrides.global.Context.sockets = [
    #   "wayland"
    #   "x11"
    #   "fallback-x11"
    # ];
  };
}
