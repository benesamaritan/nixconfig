{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -- Development Environments --
    devbox

    # -- API Development & Testing --
    bruno                    # API testing tool
    # bruno-cli              # Bruno, but CLI

    # -- AI CLI Tools --
    opencode               # AI Agent on terminal
    gemini-cli
    # copilot-cli

    # -- Git Helpers --
    lazygit
    koji                     # Interactive CLI for conventional commit
    lazyworktree             # TUI for Git worktree management
    hub                      # GitHub CLI wrapper
    
    # -- Miscellaneous Tools --
    tokei                    # Count LoC
    glow                     # Render MD on terminal
    publii                   # Static Site CMS
    h                        # Fast project navigation
    surge-cli                # Surge.sh CDN CLI
    zed-editor
    lazysql
    dbeaver-bin
  ];

  programs.git-worktree-switcher.enable = true;
}
