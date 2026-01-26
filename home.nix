{ config, pkgs, hostname, username, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${name}";
  };
in

{
  imports = [
    ./apps
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    username = "${username}";
    homeDirectory = "/home/${username}";
    shell.enableShellIntegration = true;
    sessionPath = [
      "$HOME/.local/share/bun/bin"
    ];
    shellAliases = {
      ".." = "cd ..";
      cd = "z";
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -l --icons --git -a";
      lt = "eza --tree --level=2 --icons";
      gc = "git clone";
      ossw = "git add --all && sudo nixos-rebuild switch --flake .#${hostname}";
      hmsw = "git add --all && home-manager switch --flake .#${username}";
    };
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      TERMINAL = "wezterm";
      BROWSER = "zen";
      NIXOS_OZONE_WL = "1";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
      CARGO_HOME = "$HOME/.local/share/cargo";
      BUN_INSTALL = "$HOME/.local/share/bun";
    };
    # file = {
    # };
  };

  xdg.configFile = {
    # "alacritty"         = link "alacritty";
    # "tmux"              = link "tmux";
    # "nvim"              = link "nvim";
    "niri"                = link "niri";
    "DankMaterialShell"   = link "DankMaterialShell";
    "wezterm"             = link "wezterm";
    "kanshi"              = link "kanshi";
    "kanata"              = link "kanata";
    "helix"               = link "helix";
    "starship.toml"       = link "starship.toml";
    "fastfetch"           = link "fastfetch";
    # "mimeapps.list" = {
    #   source = [
    #     "gtk-3.0" # force = true;
    #     "gtk-4.0" # force = true;
    #     # "gtk-4.0".force = true;
    #   ];
    #   force = true;
    # };
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
          gtk-theme = "Breeze-Dark";
          color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    gtk2.force = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style = {
      # name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze;
    };
  };
}
