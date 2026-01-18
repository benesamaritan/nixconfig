{ pkgs, git, inputs, ... }:

{
  home.packages = with pkgs; [
    devbox

    # -- PHP Ecosystem --
    psysh
    phpactor

    # -- Lua Ecosystem --
    lua-language-server
    stylua

    # -- Cloud & Infrastructure --
    #google-cloud-sdk

    # -- JS / Node Ecosystem --
    #nodejs_20
    #pnpm

    # -- API Development & Testing --
    bruno             # API testing tool
    k6                # Modern load testing tool in CLI.

    # -- LSP & Formatter --
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"
    nodePackages.typescript-language-server
    nodePackages.prettier
    yaml-language-server
    taplo
    shfmt

    # -- Web Utils --
    jq
    imagemagick
    hurl

    # -- Tools
    act               # Run GH Action locally
    tldx              # Check domain avaibiliby from CLI
    flawz             # CVEs look up
    lazygit
    lazysql
    lazyssh
    #lazynpm
    #httpie
    #curlie
    tokei             # Count lines of code
    glow              # Render MD on terminal
    zellij            # Tmux Alt.
    #process-compose   # Docker-Compose Alt. for non-container development
    nodePackages.browser-sync
    opencode
    vscodium

    # Purely for fun
    smassh
    typespeed
    ttyper
    inputs.gittype.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.octotype.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.fish = {
    interactiveShellInit = ''
    '';
  };

  programs.fd.enable = true;

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };

  programs.bat.enable = true;

#   programs.jujutsu = {
#    enable = false;
#    settings = {
#      user = {
#        name = "${git.username}";
#        email = "${git.email}";
#      };
#      ui = {
#        editor = "nvim";
#      };
#    };
#  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [ 
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
    };
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
