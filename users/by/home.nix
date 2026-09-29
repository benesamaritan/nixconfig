{
  config,
  lib,
  ...
}:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Repositories/github/benesamaritan/dotfiles/${name}";
  };
in

{
  imports = [
    ../profiles/services
    ../profiles/personal
    ../profiles/dev
    ../profiles/work
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.05";
    username = "by";
    homeDirectory = "/home/by";
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
    pointerCursor.enable = true;
    preferXdgDirectories = true;
  };

  xdg = {
    enable = true;
    configFile = {
      # "wezterm" = link "wezterm";
      # "kanata" = link "kanata";
      # "helix" = link "helix";
      # "starship.toml" = {
      #   enable = false;
      #   link "starship.toml";
      # };
      "fastfetch" = link "fastfetch";
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
      commit = {
        gpgSign = true;
      };
    };
    signing = {
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
