{ config, pkgs, inputs, ... }:

{
  imports = [
    ./fonts.nix
    ./wm.nix
    ./../apps/user-lv.nix
    ./../apps/web-apps.nix
    ./../apps/online-llm-cli.nix
  ];

  home.stateVersion = "24.05";

  home.file = {
    ".config/nvim".source = ./../config-files/nvim;
    ".config/tmux".source = ./../config-files/tmux;
    ".config/alacritty".source = ./../config-files/alacritty;
    ".config/mango".source = ./../config-files/mango;
    ".config/btop".source = ./../config-files/btop;
    ".config/cava".source = ./../config-files/cava;
    ".config/fastfetch".source = ./../config-files/fastfetch;
  };

  programs.starship.enable = true;
  programs.alacritty.enable = true;

  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
        alias gc="git clone"
      '';
      plugins = [  ];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "benesamaritan";
        email = "samaritan@autistici.org";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh"; 
    };
  };
}
