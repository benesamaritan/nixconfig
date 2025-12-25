{ pkgs, inputs, username, git, ... }:

{
  home.packages = with pkgs; [
    jq
    duf
    dust
    tokei
    glow
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

  programs.starship.enable = true;
  programs.alacritty.enable = true;
  programs.fd.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
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

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin";
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
      inline_height = 20;
    };
  };
}
