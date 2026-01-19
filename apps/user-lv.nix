{ pkgs, inputs, username, git, ... }:

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

  programs.zen-browser.enable = true;

  home.packages = with pkgs; [
    alacritty
    starship
    thunderbird
    #inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta
    appimage-run # use which command to look up path to be put onto lutris or other tools
    easyeffects
    haruna
    #vlc
    #fastfetch
    helix
    hx-lsp
    wezterm
    zed-editor
    gnome-feeds
    liferea
    kdePackages.alligator
    kdePackages.akregator

    # CLI Tools
    tealdeer                # Man Pages in a nutshell
    television              # TUI for fzf
    disktui                 # Disk utility
    lazyjournal             # Journalctl
    systemd-manager-tui     # Systemd manager
    navi                    # Cheatsheets
    bulletty                # RSS Reader

    # Nix CLI Tools
    manix
    nh
    nix-tree
    #nix-output-monitor
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
