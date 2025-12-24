{ config, pkgs, inputs, ... }:

{
  imports = [
    ./mango.nix
    ./dms.nix
    ./apps-user.nix
    ./copilot-cli.nix
    ./gemini-cli.nix
    ./opencode.nix
    ./zen-browser.nix
    ./web-apps.nix
  ];

  home.stateVersion = "24.05";

  home.file = {
    ".config/nvim".source = ./../dot-config/nvim;
    ".tmux.conf".source = ./../dot-config/tmux.conf;
    ".config/alacritty/alacritty.yml".source = ./../dot-config/alacritty/alacritty.yml;
  };

  programs.starship.enable = true;
  programs.alacritty.enable = true;
  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      plugins = [
      
      ];
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
