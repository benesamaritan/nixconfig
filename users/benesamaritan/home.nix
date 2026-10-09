{
  config,
  lib,
  pkgs,
  inputs,
  username,
  ...
}:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repositories/github/benesamaritan/dotfiles/${name}";
  };
in

{
  imports = [
    inputs.nix-index-database.homeModules.default
    inputs.agenix.homeManagerModules.default
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./age.nix
    ../../profiles/personal
    ../../profiles/dev
    # ../../profiles/work
    ../../services
  ];

  programs.home-manager = {
    enable = true;
    path = lib.mkDefault "$HOME/.config/home-manager";
  };

  home = {
    stateVersion = "25.05";
    username = username;
    homeDirectory = "/home/${username}";
    shell.enableShellIntegration = true;
    shellAliases = {
      ".." = "cd ..";
      cls = "clear";
      ff = "fastfetch";
      ns = "nh search";
      nhs = "nh home switch .";
    };
    sessionVariables = {
      TERMINAL = "wezterm";
      BROWSER = "zen";
    };
    preferXdgDirectories = true;
  };

  # No nix.settings here: Determinate Nix owns /etc/nix/nix.conf (flakes enabled
  # by default, trusted-users in nix.custom.conf). A user-level nix.conf cannot
  # set trusted-users. The GitHub token is injected via ./age.nix instead.

  targets.genericLinux = {
    enable = true;
    # Mesa-only host (Intel Iris Xe): automatic driver setup via
    # /run/opengl-driver. On first switch, activation prints a one-time
    # `sudo …non-nixos-gpu-setup` command if drivers are missing or stale;
    # the warning repeats on every switch until it is run.
    gpu.enable = true;
  };

  nixpkgs.config = { allowUnfree = true; };

  xdg = {
    enable = true;
    configFile = lib.mkDefault {
      "wezterm" = link "wezterm";
      "kanata" = link "kanata";
      "helix" = link "helix";
      "starship.toml" = link "starship.toml";
      "fastfetch" = link "fastfetch";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "benesamaritan";
        email = "243715333+benesamaritan@users.noreply.github.com";
      };
      submodule.recurse = true;
      commit.gpgSign = true;
    };
    signing = {
      key = "3C703A64157458C1";
      signByDefault = true;
    };
    ignores = [
      ".env"
      ".DS_Store"
      ".devbox/"
      "node_modules/"
      "vendor/"
      "*.log"
      "*.swp"
      "*.aux"
      "*.out"
    ];
  };
}
