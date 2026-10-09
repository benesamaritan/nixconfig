{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    gimp
    lynx                        # Web Browser for your terminal
    browsh                      # Web Browser for terminal (using headless firefox)
    # inputs.affinity-nix.packages.x86_64-linux.affinity-v3
  ];
  programs = {
    onlyoffice.enable = true;
    thunderbird.enable = false;
    obs-studio.enable = true;
    wezterm = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
