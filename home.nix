{ config, pkgs, lib, hostname, username, git, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${name}";
  };
in

{
  imports = [
    ./modules/catppuccin-user.nix
    #./apps/tmux.nix
    # ./apps/nvim.nix
    ./apps/user-lv.nix
    ./apps/web-apps.nix
    # ./apps/webdev.nix
    ./apps/graphics.nix
    ./apps/office.nix
    ./apps/teaching.nix
    # ./apps/logseq.nix
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
      # osu = "env DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 appimage-run /home/${username}/Lutris/osu/osu.AppImage";
      ossw = "git add --all && sudo nixos-rebuild switch --flake .#${hostname}";
      hmsw = "git add --all && home-manager switch --flake .#${username}";
    };
    sessionVariables = {
      # EDITOR = "nvim";
      # VISUAL = "nvim";
      # QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
      # TERMINAL = "alacritty";
      BROWSER = "zen";
      NIXOS_OZONE_WL = "1";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
      CARGO_HOME = "$HOME/.local/share/cargo";
      BUN_INSTALL = "$HOME/.local/share/bun";
    };
  };

  xdg.configFile = {
    # "alacritty"         = link "alacritty";
    # "tmux"              = link "tmux";
    # "nvim"              = link "nvim";
    "wezterm"             = link "wezterm";
    "kanshi"              = link "kanshi";
    "starship.toml"       = link "starship.toml";
    "fastfetch"           = link "fastfetch";
    "niri"                = link "niri";
    "DankMaterialShell"   = link "DankMaterialShell";
    "helix"               = link "helix";
    # "mimeapps.list" = {
    #   "mimeapps.list" = link "mimeapps.list";
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
    # gtk3.extraConfig = {
    #   gtk-application-prefer-dark-theme = 1;
    # };
    # gtk4.extraConfig = {
    #   gtk-application-prefer-dark-theme = 1;
    # };
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };
}
