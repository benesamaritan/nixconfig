{ config, pkgs, lib, hostname, username, git, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${name}";
  };
in

{
  imports = [
    ./apps/tmux.nix
    ./apps/nvim.nix
    ./apps/user-lv.nix
    ./apps/web-apps.nix
    ./modules/catppuccin-user.nix
    ./apps/webdev.nix
    ./apps/graphics.nix
    ./apps/office.nix
    ./apps/teaching.nix
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  xdg.configFile = {
    "alacritty"     = link "alacritty";
    #"atuin"         = link "atuin";
    "tmux"          = link "tmux";
    "nvim"          = link "nvim";
    #"btop"          = link "btop";
    "starship.toml" = link "starship.toml";
    #"cava"          = link "cava";
    "fastfetch"     = link "fastfetch";
    "kanshi"        = link "kanshi";
    #"lazydocker"    = link "lazydocker";
    #"lazygit"       = link "lazygit";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
    TERMINAL = "alacritty";
    BROWSER = "zen";
    NIXOS_OZONE_WL = "1";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
    CARGO_HOME = "$HOME/.local/share/cargo";
    BUN_INSTALL = "$HOME/.local/share/bun";
  };

  home = {
    sessionPath = [
      "$HOME/.local/share/bun/bin"
    ];
    shellAliases = {
      ".." = "z ..";
      cd = "z";
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -l --icons --git -a";
      lt = "eza --tree --level=2 --icons";
      gc = "git clone";
      osu = "env DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 appimage-run /home/${username}/Lutris/osu/osu.AppImage";
      ossw = "git add --all && sudo nixos-rebuild switch --flake .#${hostname}";
      hmsw = "git add --all && home-manager switch --flake .#${username}";
    };
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
