{
  description = "Nix System for Standard Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix.url = "github:ryantm/agenix";
    devenv.url = "github:cachix/devenv";
    # treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix.url = "github:mrshmllow/affinity-nix";
  };

  nixConfig = {
    extra-substituters = [ 
      "https://devenv.cachix.org"
      # "https://nix-gaming.cachix.org"
      "https://catppuccin.cachix.org"
      "https://cache.forall.systems"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      "cache.forall.systems:5PmD7QO4MSF8YgyRZtkSGXRDo96H3bybIf2SsQh8ScI="
    ];
  };

  outputs = inputs @ {
      self,
      nixpkgs,
      home-manager,
      nixgl,
      affinity-nix,
      ...
    }: {
    homeConfigurations."by" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { 
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ nixgl.overlay ];
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./users/by/home.nix
      ];
    };
  };
}
