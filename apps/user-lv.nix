{ pkgs, inputs, git, ... }:

{
  # User-specific packages installed in the home environment
  home.packages = with pkgs; [
    # cmatrix - terminal screensaver with Matrix-style falling characters
    cmatrix
    
    # fastfetch - fast system information tool displaying OS, hardware, and environment details
    fastfetch
    
    # nix-search-cli - command-line tool for searching NixOS packages
    nix-search-cli
    
    # Thunderbird - email client with calendar and contact management
    thunderbird
    
    # Anytype - local-first knowledge management and note-taking application
    anytype
  ];

  # Enable Starship - cross-shell prompt with Git integration and customizable themes
  programs.starship.enable = true;
  
  # Enable Alacritty terminal emulator
  programs.alacritty.enable = true;
  
  # Enable fd - fast and user-friendly alternative to 'find' command
  programs.fd.enable = true;

  # Fish shell configuration
  programs.fish = {
    enable = true;
      # Shell initialization commands
      interactiveShellInit = ''
        set fish_greeting
        alias gc="git clone"
      '';
      # plugins = [  ];
  };

  # Git version control configuration
  programs.git = {
    enable = true;
    settings = {
      # User identity for Git commits
      user = {
        name = "${git.user}";
        email = "${git.email}";
      };
    # Set 'main' as the default branch name for new repositories
    init.defaultBranch = "main";
    };
  };

  # GitHub CLI configuration
  programs.gh = {
    enable = true;
    settings = {
      # Use SSH protocol for Git operations (more secure than HTTPS)
      git_protocol = "ssh";
    };
  };

  # fzf - command-line fuzzy finder for searching files, history, and more
  programs.fzf = {
    enable = true;
    # Integrate fzf with Fish shell for enhanced command completion
    enableFishIntegration = true;
  };

  # eza - modern replacement for 'ls' with colors, icons, and Git integration
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    # Automatically show icons for file types
    icons = "auto";
    # Show Git status information for files
    git = true;
  };

  # zoxide - smarter 'cd' command that learns your most-used directories
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # bat - cat clone with syntax highlighting and Git integration
  programs.bat = {
    enable = true;
    config = {
      # Use GitHub theme for syntax highlighting
      theme = "GitHub";
    };
  };

  # btop - resource monitor showing CPU, memory, disk, network, and processes
  programs.btop = {
    enable = true;
    settings = {
      # Use Dracula color theme for btop interface
      color_theme = "dracula";
    };
  };

  # ripgrep - fast recursive search tool respecting .gitignore
  programs.ripgrep = {
    enable = true;
    # Limit line length for better readability in search results
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };

  # atuin - magical shell history synchronization and search tool
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # Use compact display style for history
      style = "compact";
      # Show 20 lines of history in inline mode
      inline_height = 20;
    };
  };
}
