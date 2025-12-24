{ config, pkgs, ... }:

{
  # Enable uinput kernel module for userspace input device creation (required by Kanata)
  hardware.uinput.enable = true;
  
  # Kanata keyboard remapping service configuration
  services.kanata = {
    # Enable Kanata service to run at system startup
    enable = true;
    
    # Configure keyboard instances - each keyboard can have its own mapping
    keyboards = {
      # Default keyboard configuration
      default = {
        # Path to Kanata configuration file defining key mappings and layers
        configFile = ./../config-files/kanata/kanata.kbd;

        # Or you could dump kanata.kbd into
        # config = ''
        #   (defsrc caps a s d f)
        #   (defalias escctrl (tap-hold 100 100 esc lctl))
        #   (deflayer base @escctrl a s d f)
        # '';
      };
    };
  };
  
  # Install Kanata package for manual configuration and testing
  environment.systemPackages = [ pkgs.kanata ];
}
