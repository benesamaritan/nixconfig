{ pkgs, git, ... }:

{
  home.packages = with pkgs; [
    # -- Core Development --
    devbox

    # -- PHP Ecosystem --
    psysh
    phpactor
    composer
    wp-cli

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
    nodePackages.tailwindcss-language-server
    nodePackages.typescript-language-server
    nodePackages.prettier
    yaml-language-server
    taplo
    shfmt

    # -- Web Utils --
    jq
    imagemagick

    # -- Tools
    #dbeaver-bin
    mycli
    act
    lazygit
    lazydocker
    podman-compose
  ];

  programs.fd.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };

  programs.jujutsu = {
    enable = false;
    settings = {
      user = {
        name = "${git.username}";
        email = "${git.email}";
      };
      ui = {
        editor = "nvim";
      };
    };
  };

  # -- Direnv Configuration --
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };
}
