{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    mango.url = "github:DreamMaoMao/mango";
    dms.url = "github:AvengeMedia/DankMaterialShell";
    opencode.url = "github:AodhanHayter/opencode-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];
      flake = {
        nixosConfigurations = {
          sol = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            
            modules = [
              ./configuration.nix
              inputs.nix-flatpak.nixosModules.nix-flatpak
              inputs.home-manager.nixosModules.home-manager
              inputs.mango.nixosModules.mango
              inputs.dms.nixosModules.dank-material-shell
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "backup";
                  extraSpecialArgs = { inherit inputs; };
                  users."bye" = import ./modules/home.nix;
                };
              }
            ];
          };
        };
      };
    };
}
