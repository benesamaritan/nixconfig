{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    wezterm
    bitwarden-desktop
    thunderbird
    inkscape
    gimp
    lynx # Web Browser for your terminal
    browsh # Web Browser for terminal (using headless firefox)
    # inputs.affinity-nix.packages.x86_64-linux.v3
  ];
}
