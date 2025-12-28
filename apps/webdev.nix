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
    google-cloud-sdk

    # -- JS / Node Ecosystem --
    #nodejs_20
    pnpm

    # -- Rust Ecosystem --
    cargo
    rustc
    rust-analyzer

    # -- API Development & Testing --
    bruno
    httpie
    k6

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
    #dbeaver-bin
    mycli
    act
    lazygit
    lazydocker
    podman-compose
    process-compose
    nodePackages.browser-sync
    pkgs.gemini-cli
    inputs.opencode.packages.${pkgs.system}.default
  ];

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
      gh-copilot
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
      aliases = {
        co = "copilot";
        ce = "copilot explain";
        cs = "copilot suggest";
      };
    };
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
