{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    gimp
    inkscape
    affinity-v3
  ];
  programs.wezterm = {
      enableBashIntegration = true;
  };
}
