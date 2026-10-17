{
  config,
  lib,
  pkgs,
  inputs,
  username,
  ...
}:

{
  imports = [
    inputs.nix-index-database.homeModules.default
    inputs.agenix.homeManagerModules.default
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./age.nix
    ../../services
    ../../profiles/personal
    ../../profiles/dev
    # ../../profiles/work
    ./programs.nix
    ./dotfiles.nix
    ./genericLinux.nix
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
  };

  nixpkgs.config = { allowUnfree = true; };

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
