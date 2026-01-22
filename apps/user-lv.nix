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
      submodule.recurse = true;
    };
    lfs.enable = true;
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
    # alacritty
    starship
    thunderbird
    keepassxc
    wezterm
    helix
    # hx-lsp
    zed-editor
    logseq
    trilium-desktop
    # gnome-feeds
    # kdePackages.alligator
    # kdePackages.akregator
    rssguard     # rss reader
    appimage-run # use which command to look up path to be put onto lutris or other tools
    easyeffects
    haruna
    # vlc
    fastfetch    # unixporn SS masterace
    
    # CLI & TUI Tools
    lynx                    # Web Browser for your terminal
    yazi                    # File Manager for your terminal
    yaziPlugins             # Plugins for pkg above
    tealdeer                # Man Pages in a nutshell
    television              # TUI for fzf
    disktui                 # Disk utility
    ncdu                    # Disk usage analyzer
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
    manix               # search nix options
    nh                  # search pkgs, alias (for nixos, home-manager, and garbage collect)
    nix-tree            # dependencies tree on nix store
    nix-output-monitor  # pipe build command to pretty nom output
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
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

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      atuin init fish | source
      starship init fish | source
    '';
  };

  systemd.user.services.keepassxc = {
    Unit = {
      Description = "KeePassXC Password Manager";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc --minimized";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
  systemd.user.services.thunderbird = {
    Unit = {
      Description = "Thunderbird Email Client";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.thunderbird}/bin/thunderbird";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };   
  systemd.user.services.easyeffects = {
    Unit = {
      Description = "EasyEffects Audio Processor";
      After = [ "pipewire-pulse.service" ];
      PartOf = [ "pipewire-pulse.service" ];
    };
    Service = {
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };   
}
