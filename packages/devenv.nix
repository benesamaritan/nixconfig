{ pkgs, username, ... }:

{
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.test/127.0.0.1";
    };
  };

  # 2. (Optional) Open ports for web servers if you need external access
  # networking.firewall.allowedTCPPorts = [ 80 443 3000 8000 ];
  # networking.firewall.allowedTCPPorts = [ 22 80 ];

  environment.systemPackages = with pkgs; [
    devbox

    # -- PHP Ecosystem --
    # psysh
    # phpactor
    intelephense

    # -- Cloud & Infrastructure --
    # google-cloud-sdk
    # koyeb-cli

    # -- JS / Node Ecosystem --
    # nodejs_20
    # pnpm

    # -- API Development & Testing --
    bruno            # API testing tool
    # bruno-cli          # Bruno, but CLI
    k6                 # Modern load testing tool in CLI.

    # -- LSP & Formatter --
    # fish-lsp    
    # bash-language-server
    yaml-language-server
    marksman           # Markdown LSP
    taplo              # TOML, and Cross-Config LSP
    # systemd-lsp
    vscode-json-languageserver
    # nodePackages."vscode-langservers-extracted"
    # nodePackages."@tailwindcss/language-server"
    # nodePackages.typescript-language-server
    # nodePackages.prettier
    lua-language-server
    # stylua
    # shfmt

    # -- Web Utils --
    # jq
    # imagemagick
    # hurl

    # -- Tools
    act                 # Run GH Action locally
    tldx                # Check domain avaibiliby from CLI
    flawz               # CVEs look up
    lazytrivy           # TUI vulnerability scanning using trivy
    lazysql
    dbeaver-bin
    tokei               # Count lines of code
    glow                # Render MD on terminal
    publii              # Static Site CMS with GUI
    opencode            # AI Agent on terminal
    surge-cli           # CLI for the surge.sh CDN
    curlie
    # httpie
    # fd
    # lazysql
    # lazyssh
    # lazynpm
    # zellij            # Tmux Alt.
    # process-compose   # Docker-Compose Alt. for non-container development
    # nodePackages.browser-sync
    # vscodium
  ];

  programs.git-worktree-switcher.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      devbox = "devbox shell --shell /run/current-system/sw/bin/bash";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if set -q DEVBOX_SHELL_ENABLED
        starship init fish | source
      end
    '';
    shellAliases = {
      dse = "env SHELL=bash devbox shell"; # Devbox shell enter, using bash inside instead of fish
    };
  };
 
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    direnvrcExtra = "\n
      echo 'Good Luck ${username}'\n
      echo 'Wish you all the best'
    ";
  };

 #  programs.jujutsu = {
 #   enable = false;
 #   settings = {
 #     user = {
 #       name = "${git.username}";
 #       email = "${git.email}";
 #     };
 #     ui = {
 #       editor = "nvim";
 #     };
 #   };
 # };
}
