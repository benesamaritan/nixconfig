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
  in

  {
    nixosConfigurations = {
      # Main desktop configuration
      sol = let
        hostVars = import ./hosts/sol/vars.nix { inherit nixpkgs; };
        userVars = import ./users/bye/vars.nix { inherit nixpkgs; };
        vars = hostVars // userVars;
      in lib.nixosSystem {
        inherit (vars) system;
        pkgs = import nixpkgs {
          inherit (vars) system;
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit inputs;
        } // vars;
        modules = [
          ./hosts/sol/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      # Main user configuration
      bye = let
        hostVars = import ./hosts/sol/vars.nix { inherit nixpkgs; };
        userVars = import ./users/bye/vars.nix { inherit nixpkgs; };
        vars = hostVars // userVars;
      in home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit (vars) system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs;
        } // vars;
        modules = [
          ./users/bye/home.nix
        ];
      };
    };
  };
}
