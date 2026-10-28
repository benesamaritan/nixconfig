{ ... }:

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
#       "niri"            = link "niri";
      "nvim"            = link "nvim";
      "kanata"          = link "kanata";
      "wezterm"         = link "wezterm";
      "alacritty"       = link "alacritty";
    };
  };
}
