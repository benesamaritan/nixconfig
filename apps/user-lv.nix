{ pkgs, inputs, username, git, ... }:

{
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

  home.packages = with pkgs; [
    alacritty
    starship
    thunderbird
    inputs.zen-browser.packages.${pkgs.system}.beta
    appimage-run # use which command to look up path to be put onto lutris or other tools
    easyeffects

    # CLI Tools
    tealdeer                  # Man Pages in a nutshell
    television                # TUI for fzf

    # Nix CLI Tools
    manix
    nh
    nix-tree
    nix-output-monitor

    # Linux System CLI Tools
    disktui       # TUI for disk utility
    lazyjournal   # TUI for journalctl
    systemd-manager-tui     # TUI for Sytemd related
    navi          # CLI Cheatsheets
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
