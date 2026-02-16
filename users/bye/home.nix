{ config, username, git, ... }:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/github.com/benesamaritan/dotfiles/${name}";
  };
in

{
  imports = [
    ../../apps
    ../../services
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
      ".."       = "cd ..";
      cd         = "z";
      cat        = "bat";
      ls         = "eza --icons";
      ll         = "eza -l --icons --git -a";
      lt         = "eza --tree --level=2 --icons";
      cls        = "clear";
      stat       = "git status";
      add        = "git add --all";
      commit     = "git commit -am";
      clone      = "git clone";
      fetch      = "git fetch";
      pull       = "git pull";
      push       = "git push";
      pushnew    = "git push --set-upstream";
      checkout   = "git checkout";
      newbranch  = "git checkout -b";
      list       = "git branch -l";
      remoteadd  = "git remote add";
      remoteget  = "git remote get-url";
    };
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      TERMINAL = "wezterm";
      BROWSER = "zen";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
      CARGO_HOME = "$HOME/.local/share/cargo";
      BUN_INSTALL = "$HOME/.local/share/bun";
    };
  };

  xdg.configFile = {
    "niri"                = link "niri";
    "DankMaterialShell"   = link "DankMaterialShell";
    "wezterm"             = link "wezterm";
    "kanshi"              = link "kanshi";
    "kanata"              = link "kanata";
    "helix"               = link "helix";
    "starship.toml"       = link "starship.toml";
    "fastfetch"           = link "fastfetch";
  };

  programs.git = {
    settings = {
      user = {
        name = "${git.user}";
        email = "${git.email}";
      };
      submodule.recurse = true;
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
