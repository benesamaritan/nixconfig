{ config, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = "return require 'wezterm-config'";
  };
}
