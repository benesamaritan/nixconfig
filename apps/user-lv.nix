{ pkgs, inputs, username, git, ... }:

{
  home.packages = with pkgs; [
    alacritty
    jq
    duf
    dust
    tokei
    glow
    btop
    kanshi
    atuin
    starship
    wl-clipboard
    nix-search-cli
    thunderbird
    vscodium
    inputs.zen-browser.packages.${pkgs.system}.beta
    anytype
    appimage-run # use which command to look up path to be put onto lutris or other tools
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
        atuin init fish | source
        starship init fish | source
      '';
  };

  programs.fd.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${git.user}";
        email = "${git.email}";
      };
    init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };
}
