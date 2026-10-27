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
      "alacritty" = link "alacritty";
      "atuin" = link "atuin";
      "btop" = link "btop";
      "cava" = link "cava";
      "Kvantum" = link "Kvantum";
      "lazydocker" = link "lazydocker";
      "lazygit" = link "lazygit";
      "niri" = link "niri";
      "nvim" = link "nvim";
      "tmux" = link "tmux";
    };
  };
}
