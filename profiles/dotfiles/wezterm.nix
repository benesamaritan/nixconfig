{ config, ... }: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = "return require 'wezterm-config'";
  };
}
