{
  lib,
  inputs,
  username,
  ...
}:

{
  imports = [
    ./age.nix
    ./programs.nix
    ./genericLinux.nix
    ../../services
    ../../profiles/personal
    ../../profiles/dev
    ../../profiles/work
    ../../profiles/dotfiles
    inputs.agenix.homeManagerModules.default
    inputs.nix-index-database.homeModules.default
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  news.display = "show";

  nix.settings.use-xdg-base-directories = true;

  programs.home-manager = {
    enable = true;
    path = lib.mkDefault "$HOME/.config/home-manager";
  };

  home = {
    stateVersion = "25.05";
    username = username;
    homeDirectory = "/home/${username}";
    shell.enableShellIntegration = true;
    overwriteBackup = true;
    preferXdgDirectories = true;
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
      HISTFILE = "$XDG_STATE_HOME/bash/history";
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
      NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
      WINEPREFIX = "$XDG_DATA_HOME/wine";
      GTK2_RC_FILES = lib.mkForce "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      XCURSOR_PATH = "$XDG_DATA_HOME/icons:/usr/share/icons";
      CODEX_HOME = "$XDG_CONFIG_HOME/codex";
      PI_CODING_AGENT_DIR = "$XDG_CONFIG_HOME/pi/agent";
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
