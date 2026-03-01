{ ... }:

{
  imports = [
    # ./devenv.nix
    ./kanata.nix
    # ./kanshi.nix
    #./wlr-randr.nix
    ./syncthing.nix
    ./system-lv.nix
    ./gaming.nix
    #./android-debug.nix
    ./../modules/swapfile.nix
  ];
}
