{ pkgs, ... }:

{
	home.packages = with pkgs; [
		# Terminal Emulator
    # alacritty
    wezterm

    # CLI & TUIs
    starship
    helix
    # helix-gpt
    # hx-lsp
    lynx                    # Web Browser for your terminal
    yazi                    # File Manager for your terminal
    fastfetch               # unixporn SS masterace

    # Helper
    tealdeer                # Man Pages in a nutshell
    television              # TUI for fzf
    disktui                 # Disk utility
    ncdu                    # Disk usage analyzer
    lazyjournal             # Journalctl
    systemd-manager-tui     # Systemd manager
    navi                    # Cheatsheets
    # bulletty                # RSS Reader

    # Fun Land
    # smassh
    # typespeed
    ttyper
    # inputs.gittype.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.octotype.packages.${pkgs.stdenv.hostPlatform.system}.default
    pipes-rs                # Pipes Screensaver like on Classic Windows (Rust rewrite variant)
    cmatrix                 # Matrix-like Screensaver
    discordo                # Discord
		# spotifycli
    # inputs.gophertube.packages.${stdenv.hostPlatform.system}.default
    gophertube
	];

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

  programs.fd.enable = true;
  programs.bat.enable = true;
  programs.atuin.enable = true;

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
