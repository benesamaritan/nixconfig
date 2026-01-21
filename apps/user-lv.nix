{ pkgs, inputs, git, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${git.user}";
        email = "${git.email}";
      };
      init.defaultBranch = "main";
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [ 
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.fd.enable = true;
  programs.bat.enable = true;
  programs.zen-browser.enable = true;

  home.packages = with pkgs; [
    alacritty
    starship
    thunderbird
    keepassxc
    wezterm
    helix
    # hx-lsp
    zed-editor
    lynx
    logseq
    trilium-desktop
    # gnome-feeds
    # liferea
    kdePackages.alligator
    kdePackages.akregator
    appimage-run # use which command to look up path to be put onto lutris or other tools
    easyeffects
    haruna
    # vlc
    # fastfetch
    
    # CLI & TUI Tools
    tealdeer                # Man Pages in a nutshell
    television              # TUI for fzf
    disktui                 # Disk utility
    ncdu
    lazyjournal             # Journalctl
    systemd-manager-tui     # Systemd manager
    navi                    # Cheatsheets
    bulletty                # RSS Reader
    discordo                # Discord
    commit                  # Git Commit msg editor
    commitlint              # Linter for git commit msg
    koji                    # Interactive CLI for conventional commit
    changelogen             # Beautiful changelog

    # Nix CLI Tools
    manix
    nh
    # nix-tree
    # nix-output-monitor
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      atuin init fish | source
      starship init fish | source
    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
  };

  programs.atuin.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
