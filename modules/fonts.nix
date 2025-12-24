{ pkgs, ... }: 

{
  # System-wide font packages configuration
  fonts.packages = with pkgs; [
    # Inter - modern, clean sans-serif font optimized for UI and readability on screens
    inter
    
    # Nerd Fonts symbols - provides programming icons and glyphs for terminal and development tools
    nerd-fonts.symbols-only
    
    # JetBrains Mono Nerd Font - monospaced font designed for coding with enhanced ligatures and icons
    nerd-fonts.jetbrains-mono
    
    # Noto Fonts - comprehensive Unicode font family supporting a wide range of scripts and languages
    noto-fonts
    
    # Noto CJK Sans - provides support for Chinese, Japanese, and Korean characters
    noto-fonts-cjk-sans
    
    # Noto Color Emoji - enables color emoji display across applications
    noto-fonts-color-emoji
  ];

  # Enable fontconfig for font management and rendering optimization
  fonts.fontconfig.enable = true;
}
