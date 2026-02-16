{ pkgs, username, ... }:

{
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.test/127.0.0.1";
    };
  };

  environment.systemPackages = with pkgs; [
    devbox
    devenv

    # -- API Development & Testing --
    bruno                    # API testing tool
    # bruno-cli              # Bruno, but CLI
    # k6                     # Modern load testing tool in CLI.

    jq
    # imagemagick
    # hurl

    # -- Tools
    # act                    # Run GH Action locally
    # tldx                   # Check domain avaibiliby from CLI
    # flawz                  # CVEs look up
    # lazytrivy              # TUI vulnerability scanning using trivy
    zed-editor
    lazysql
    dbeaver-bin
    tokei                    # Count LoC
    glow                     # Render MD on terminal
    publii                   # Static Site CMS with GUI
    h                        # Faster shell navigation of projects
    surge-cli                # CLI for the surge.sh CDN
    curlie
    # lazycli                # CLI into TUI
    # httpie
    # lazyssh
    # lazynpm

    # AI CLI Tools
    opencode                 # AI Agent on terminal
    gemini-cli
    # copilot-cli

    # GIT helper
    lazygit
    # gitbutler
    koji                     # Interactive CLI for conventional commit
    lazyworktree             # Terminal User Interface for efficient Git worktree management
    hub                      # Command-line wrapper for git that makes you better at GitHub
  ];

  programs.git-worktree-switcher.enable = true;

  programs.bash = {
    enable = true;
    completion.enable = true;
    enableLsColors = true;
    blesh.enable = true;
    undistractMe.enable = true;
  };

  programs.autojump.enable = true;
 
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    direnvrcExtra = "\n
      echo 'Good Luck ${username}'\n
      echo 'Wish you all the best'
    ";
  };
}
