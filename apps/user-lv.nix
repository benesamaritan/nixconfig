{ pkgs, inputs, git, ... }:

{
  home.packages = with pkgs; [
    cmatrix
    fastfetch
    nix-search-cli
    thunderbird
    anytype
  ];

  programs.starship.enable = true;
  programs.alacritty.enable = true;
  programs.fd.enable = true;

  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
        alias gc="git clone"
      '';
      # plugins = [  ];
  };

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

  programs.gh = {
    enable = true;
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

  programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [ "--max-columns=150" "--max-columns-preview" ];
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
      inline_height = 20;
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    disableConfirmationPrompt = true;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      sensible
      vim-tmux-navigator
      resurrect
      continuum
      yank
      tmux-which-key
    ];

    extraConfig = ''
      unbind C-b
      set -g prefix C-Space
      bind C-Space send prefix
      bind -n M-H previous-window
      bind -n M-L next-window

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # set vi-mode
      set-window-option -g mode-keys vi

      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
