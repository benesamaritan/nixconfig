{ pkgs, inputs, git, ... }:

{
  home.packages = with pkgs; [
    cmatrix
    fastfetch
    nix-search-cli
    thunderbird
    anytype
  ];

  programs.starship.enable = true;
  programs.alacritty.enable = true;
  programs.fd.enable = true;

  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
        alias gc="git clone"
      '';
      # plugins = [  ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${git.user}";
        email = "${git.email}";
      };
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
      theme = "GitHub";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
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
