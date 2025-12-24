{ config, pkgs, ... }:

{
  # Graphics hardware configuration for gaming
  hardware.graphics = {
    # Enable OpenGL/Vulkan graphics drivers
    enable = true;
    
    # Enable 32-bit graphics libraries for compatibility with older games and Wine
    enable32Bit = true;
  };

  # Steam gaming platform configuration
  programs.steam = {
    # Enable Steam client and integration
    enable = true;
    
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports for local transfers
    dedicatedServer.openFirewall = false; # Open ports for Source Dedicated Server
  };

  # Enable gamescope - micro-compositor for running games in isolated sessions with better control
  programs.gamescope.enable = true;
  
  # Enable gamemode - optimizes system performance when running games
  programs.gamemode.enable = true;

  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    # Wine Stable - compatibility layer for running Windows applications on Linux (32-bit and 64-bit support)
    wineWowPackages.stable
    
    # Winetricks - helper script for installing Windows dependencies in Wine prefixes
    winetricks
    
    # .NET SDK - required for running games and applications built with .NET framework
    dotnet-sdk
    
    # MangoHud - Vulkan/OpenGL overlay for monitoring FPS, temperatures, and system performance
    mangohud
    
    lutris # be sure to disable lutris runtime
    
    # ProtonUp-Qt - graphical tool for managing Proton-GE versions for enhanced game compatibility
    protonup-qt
  ];
}
