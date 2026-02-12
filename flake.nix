{
  description = "Nix + Flake + Standalone HM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:YaLTeR/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nsticky.url = "github:lonerOrz/nsticky";
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wooz.url = "github:negrel/wooz";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    catppuccin.url = "github:catppuccin/nix";
    # octotype.url = "github:mahlquistj/octotype/main";
    # gittype.url = "github:unhappychoice/gittype";
    # gophertube.url = "github:KrishnaSSH/gophertube";
    # trilium-notes = {
    #   url = "github:TriliumNext/Trilium/v0.101.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    # affinity-nix = {
    #   url = "github:mrshmllow/affinity-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
  inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
  }:

  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    # Helper function for NixOS system configuration
    mkSystem = { hostname, username }: 
      let
        hostVars = import ./hosts/${hostname}/vars.nix { inherit nixpkgs; };
        userVars = import ./users/${username}/vars.nix { inherit nixpkgs; };
        vars = hostVars // userVars;
        system = vars.system or "x86_64-linux";
      in lib.nixosSystem {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        specialArgs = { inherit inputs; } // vars;
        modules = [
          inputs.agenix.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.dms.nixosModules.default
          ./hosts/${hostname}/configuration.nix
        ];
      };

    # Helper function for Home Manager configuration
    mkHome = { hostname, username }:
      let
        hostVars = import ./hosts/${hostname}/vars.nix { inherit nixpkgs; };
        userVars = import ./users/${username}/vars.nix { inherit nixpkgs; };
        vars = hostVars // userVars;
        system = vars.system or "x86_64-linux";
      in home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs; } // vars;
        modules = [
          inputs.catppuccin.homeModules.catppuccin
          inputs.zen-browser.homeModules.twilight
          ./users/${username}/home.nix
        ];
      };
  in

  {
    # NixOS modules provided by this flake
    nixosModules = {
      system = import ./modules;
      packages = import ./packages;
    };

    # Home Manager modules provided by this flake
    homeManagerModules = {
      user = import ./users/bye/home.nix;
    };

    # NixOS system configurations
    nixosConfigurations = {
      sol = mkSystem { hostname = "sol"; username = "bye"; };
    };

    # Home Manager configurations
    homeConfigurations = {
      "bye" = mkHome { hostname = "sol"; username = "bye"; };
    };

    # Custom packages provided by this flake
    packages.${system} = {
      default = pkgs.hello;
      hello = pkgs.hello;
    };
  };
}
