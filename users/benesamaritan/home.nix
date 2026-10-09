{
  config,
  lib,
  pkgs,
  inputs,
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
    username = "benesamaritan";
    homeDirectory = "/home/benesamaritan";
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

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "benesamaritan"
      ];
    };
  };

  targets.genericLinux = {
    enable = true;
#     gpu.enable = true;
    nixGL = {
      packages = inputs.nixgl.packages;
      defaultWrapper = "mesa";
      installScripts = [
        "mesa"
        "mesaPrime"
      ];
    };
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
    signing.signByDefault = true;
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
