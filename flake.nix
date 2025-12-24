{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # flake-parts.url = "github:hercules-ci/flake-parts";
    # nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode.url = "github:AodhanHayter/opencode-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  };
  outputs = inputs@{ self, nixpkgs, mango, dms, home-manager, ... }: 
  let
    username = "bye";
    description = "Bayu Saputro";
    system = "x86_64-linux";
    hostname = "sol";
    shell = "fish";  
    timezone = "Asia/Jakarta";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "id_ID.UTF-8";groups = [
      "networkmanager" 
      "wheel" 
      "podman" 
      "libvirtd"
      "input" #only if using kanata.nix on configuration.nix
    ];
    xkb = {
      layout = "us";
      variant = "";
    };  
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs username description hostname groups timezone defaultLocale extraLocale xkb shell; 
      };
      modules = [
        ./configuration.nix
        mango.nixosModules.mango
        dms.nixosModules.dank-material-shell
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs username; };
            users.${username} = import ./modules/home.nix;
          };
        }     
      ];
    };
  };
}
