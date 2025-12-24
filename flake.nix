{
  description = "Nix + Flake + Standalone HM";

  inputs = {
    # NixOS unstable channel - provides the latest packages and system configuration options
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager for managing user-specific configuration and packages in a declarative way
    # The 'inputs.nixpkgs.follows' ensures home-manager uses the same nixpkgs version as the system
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # OpenCode flake - provides an open-source alternative to GitHub Copilot for code assistance
    opencode.url = "github:AodhanHayter/opencode-flake";
    
    # Zen Browser beta - a Firefox-based privacy-focused browser with enhanced features
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    # niri.url = "github:YaLTeR/niri";
    # dms = {
    #   url = "github:AvengeMedia/DankMaterialShell/a7494971fd7c4fb823d4b77a7543d77225442ce4";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # dsearch = {
    #   url = "github:AvengeMedia/danksearch";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # mango = {
    #   url = "github:DreamMaoMao/mango";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # flake-parts.url = "github:hercules-ci/flake-parts";
    # nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    # System username for the primary user account
    username = "bye";
    
    # Full name description for the user account
    description = "Bayu Saputro";
    
    # SHA-512 hashed password for secure user authentication
    hashPasswd = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
    
    # Target system architecture - x86_64 Linux for standard desktop/laptop systems
    system = "x86_64-linux";
    
    # Import nixpkgs with configuration allowing proprietary/non-free software packages
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    
    # Hostname identifier for the system
    hostname = "sol";
    
    # Default shell for the user - Fish shell provides user-friendly interactive features
    shell = "fish";
    
    # System timezone setting for Jakarta, Indonesia
    timezone = "Asia/Jakarta";
    
    # Primary system locale for US English language and formatting
    defaultLocale = "en_US.UTF-8";
    
    # Additional locale for Indonesian language-specific formatting (currency, dates, etc.)
    extraLocale = "id_ID.UTF-8";
    
    # User group memberships for various system permissions and access control
    groups = [
      "networkmanager"  # Allows managing network connections
      "wheel"           # Grants sudo/administrative privileges
      "podman"          # Enables container management with Podman
      "libvirtd"        # Provides access to virtual machine management
      "input" #only if using kanata.nix on configuration.nix
      "uinput" #only if using kanata.nix
    ];
    
    # Keyboard layout configuration - US QWERTY layout with no variant
    xkb = {
      layout = "us";
      variant = "";
    };
    
    # Git configuration for version control - username and email for commits
    git = {
      user = "benesamaritan";
      email = "243715333+benesamaritan@users.noreply.github.com";
    };
  in {
    # NixOS system configuration for the specified hostname
    # This defines the complete system-level configuration including kernel, services, and packages
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs username hashPasswd description hostname groups timezone defaultLocale extraLocale xkb shell;
      };
      modules = [
        # Main system configuration file containing boot, networking, services, and hardware settings
        ./configuration.nix
      ];
    };
    
    # Home Manager configuration for user-specific settings and packages
    # Manages dotfiles, user packages, and program configurations in a declarative way
    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs username git; };
        modules = [
          # User-level configuration file for home directory management and user packages
          ./home.nix
        ];
      };
    };
  };
}
