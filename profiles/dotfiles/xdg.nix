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
      "btop"            = link "btop";
      "cava"            = link "cava";
      "niri"            = link "niri";
      "nvim"            = link "nvim";
      "tmux"            = link "tmux";
      "atuin"           = link "atuin";
      "kanata"          = link "kanata";
      "wezterm"         = link "wezterm";
      "lazygit"         = link "lazygit";
      "alacritty"       = link "alacritty";
      "lazydocker"      = link "lazydocker";
    };
  };
}
