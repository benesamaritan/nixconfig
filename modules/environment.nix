{ config, pkgs, username, ... }:

{
  imports =
  [
    # USE
    # ONLY
    # ONE!

    ./desktop.nix   # <-- using cinnamon
    #./wm.nix       # <-- using niri & dms
  ];

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      #autoLogin = {
      #  enable = true;
      #  user = "${username}";
      #};
    };
  };

  programs.xwayland.enable = true;
}
