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
    ".config/nvim".source = ./../dot-config/nvim;
    ".config/tmux".source = ./../dot-config/tmux;
    ".config/alacritty".source = ./../dot-config/alacritty;
    ".config/mango".source = ./../dot-config/mango;
    ".config/btop".source = ./../dot-config/btop;
    ".config/cava".source = ./../dot-config/cava;
    ".config/fastfetch".source = ./../dot-config/fastfetch;
    ".config/kanata".source = ./../dot-config/kanata;
    #".config/atuin".source = ./../dot-config/atuin;
    #".config/steam".source = ./../dot-config/steam;
    #".config/VSCodium".source = ./../dot-config/VSCodium;
    #".config/zed".source = ./../dot-config/zed;
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
