{ config, pkgs, inputs, ... }:

{
  # Disable nano text editor (using neovim instead)
  programs.nano.enable = false;
  
  # Enable Fish shell - user-friendly shell with syntax highlighting and autosuggestions
  programs.fish.enable = true;
  
  # Enable virt-manager for managing virtual machines with a graphical interface
  programs.virt-manager.enable = true;
  
  # Enable Firefox web browser
  programs.firefox.enable = true;
  
  # Enable dconf for storing GNOME/GTK application settings
  programs.dconf.enable = true;
  
  # Enable KDE Connect for phone-computer integration (file sharing, notifications, remote control)
  programs.kdeconnect.enable = true;

  # Exclude xterm from X server packages (using alacritty as terminal emulator)
  services.xserver.excludePackages = [ pkgs.xterm ];

  # System-wide packages available to all users
  environment.systemPackages = with pkgs; [
    # tmux - terminal multiplexer for managing multiple terminal sessions
    tmux
    
    # neovim - modern Vim-based text editor with enhanced features and plugin support
    neovim
    
    # alacritty - GPU-accelerated terminal emulator written in Rust for performance
    alacritty
    
    # vscodium - VSCode without Microsoft telemetry and proprietary components
    vscodium
    
    # Zen Browser beta - privacy-focused Firefox-based browser from inputs
    inputs.zen-browser.packages.${pkgs.system}.beta
  ];
}
