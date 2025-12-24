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
  programs.starship.enable = true;
  programs.alacritty.enable = true;

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

  home.file = {
    ".config/nvim".source = ./../dot-config/nvim;
    ".tmux.conf".source = ./../dot-config/tmux.conf;
    ".config/alacritty/alacritty.yml".source = ./../dot-config/alacritty.yml;
  };
}
