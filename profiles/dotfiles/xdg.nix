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
      "Kvantum"         = link "Kvantum";
      "alacritty"       = link "alacritty";
      "lazydocker"      = link "lazydocker";
      # starship.toml is now handled via programs.starship in starship.nix
    };
  };
}
