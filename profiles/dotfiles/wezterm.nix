{ config, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = "return require 'wezterm-config'";
  };
  home.file.".config/wezterm/wezterm-config.lua".source = ./dotfiles/wezterm/wezterm.lua;
  home.file.".config/wezterm/colors".source = ./dotfiles/wezterm/colors;
}
