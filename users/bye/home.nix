{
  config,
  username,
  git,
  ...
}:

let
  link = name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repo/github.com/benesamaritan/dotfiles/${name}";
  };
in

{
  imports = [
    ../../apps
    ../../services
    ../../profiles/dev
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.05";
    username = "${username}";
    homeDirectory = "/home/${username}";
    shell.enableShellIntegration = true;
    shellAliases = {
      ".." = "cd ..";
      cd = "z";
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -l --icons --git -a";
      lt = "eza --tree --level=2 --icons";
      cls = "clear";
      g = "git";
      gi = "git init";
      gs = "git status";
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push --set-upstream";
      gf = "git fetch && git pull --rebase";
      gcl = "git clone";
      gb = "git branch";
      gco = "git checkout";
      gu = "git submodule update --init --recursive";
      ff = "fastfetch";
      ns = "nh search";
      nos = "nh os switch .";
      nhs = "nh home switch .";
    };
    sessionVariables = {
      TERMINAL = "wezterm";
      BROWSER = "zen";
    };
  };

  xdg.configFile = {
    "niri" = link "niri";
    "DankMaterialShell" = link "DankMaterialShell";
    "wezterm" = link "wezterm";
    "kanshi" = link "kanshi";
    "kanata" = link "kanata";
    "helix" = link "helix";
    "starship.toml" = link "starship.toml";
    "fastfetch" = link "fastfetch";
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
