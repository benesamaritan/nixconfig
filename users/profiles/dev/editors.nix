{
  pkgs,
  ...
}:

{
  programs = {
    helix = {
      enable = true;
      defaultEditor = false;
    };
    vscodium.enable = true;
    zed-editor = {
      enable = true;
      defaultEditor = true;
    };
  };
}
