{
  lib,
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
    ../../profiles/work
    ../../profiles/dotfiles
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
      TERMINAL = "alacritty";
      BROWSER = "zen";
    };
    file.".config/nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
    file.".local/share/nix/trusted-settings.json".text = builtins.toJSON {
      "extra-substituters" = [
        "https://devenv.cachix.org"
        "https://catppuccin.cachix.org"
        "https://cache.forall.systems"
      ];
      "extra-trusted-public-keys" = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "cache.forall.systems:5PmD7QO4MSF8YgyRZtkSGXRDo96H3bybIf2SsQh8ScI="
      ];
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
      "devenv/"
      ".devenv*"
      "/node_modules"
      "*.log"
      "*.swp"
      "*.aux"
      "*.out"
      "desktop.ini"
      "Thumbs.db"
      ".pre-commit-config.yaml"
      "Homestead.json"
      "Homestead.yaml"
      "npm-debug.log"
      "yarn-error.log"
      "/auth.json"
      ".direnv"
      "/.agents"
      "/vendor"
      "/.fleet"
      "/.idea"
      "/.nova"
      "/.vscode"
      "/.zed"
      "/.amp"
      "/.claude"
      "/.cursor"
      "/.factory"
      "/.grok"
      "/.junie"
      "/.kiro"
      "/.pi"
      "/boost.json"
      "/opencode.json"
      "/opencode.jsonc"
    ];
  };
}
