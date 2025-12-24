{ config, pkgs, lib, username, git, ... }:

let
  link = name: { source = ./config-files/${name}; };
in
{
  imports = [
    # ./modules/wm.nix
    # ./modules/dms.nix
    ./apps/user-lv.nix
    ./apps/web-apps.nix
    ./apps/online-llm-cli.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  xdg.configFile = {
    "nvim"          = link "nvim";
    "cava"          = link "cava";
    "fastfetch"     = link "fastfetch";
    "kanshi"        = link "kanshi";
    "tmux"          = link "tmux";
    "alacritty"     = link "alacritty";
    "btop"          = link "btop";
    "atuin"         = link "atuin";
    "lazydocker"    = link "lazydocker";
    "lazygit"       = link "lazygit";
    "starship.toml" = link "starship.toml";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
          gtk-theme = "Adwaita-dark";
          color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
