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
    ../../services
    ../../profiles/personal
    ../../profiles/dev
    ../../profiles/work
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.05";
    username = "${username}";
    homeDirectory = "/home/${username}";
    shell.enableShellIntegration = true;
    shellAliases = {
      ".." = "cd ..";
      cls = "clear";
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
