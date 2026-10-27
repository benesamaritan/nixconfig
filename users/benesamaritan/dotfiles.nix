{ config, lib, ... }:

let
  link = name: {
    source = ./${name};
  };
in
{
  home.preferXdgDirectories = true;

  xdg = {
    enable = true;
    configFile = {
      "wezterm" = link "wezterm";
      "kanata" = link "kanata";
      "starship.toml" = link "starship.toml";
      "fastfetch" = link "fastfetch";
    };
  };
}
