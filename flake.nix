{
  description = "Nix + Flake + Standalone HM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    devenv.url = "github:cachix/devenv";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";

    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-monitor.url = "github:antonjah/nix-monitor";
    nsticky.url = "github:lonerOrz/nsticky";

    wooz.url = "github:negrel/wooz";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  nixConfig = {
    substituters = [
      "https://devenv.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
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

      mkSystem =
        { hostname, username }:
        let
          hostVars = import ./hosts/${hostname}/vars.nix { inherit nixpkgs; };
          userVars = import ./users/${username}/vars.nix { inherit nixpkgs; };
          vars = hostVars // userVars;
          system = vars.system or "x86_64-linux";
        in
        lib.nixosSystem {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          specialArgs = {
            inherit inputs;
          }
          // vars;
          modules = [
            ./hosts/${hostname}/configuration.nix
            inputs.agenix.nixosModules.default
            inputs.catppuccin.nixosModules.catppuccin
          ];
        };

      mkHome =
        { hostname, username }:
        let
          hostVars = import ./hosts/${hostname}/vars.nix { inherit nixpkgs; };
          userVars = import ./users/${username}/vars.nix { inherit nixpkgs; };
          vars = hostVars // userVars;
          system = vars.system or "x86_64-linux";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit inputs;
          }
          // vars;
          modules = [
            ./users/${username}/home.nix
            inputs.catppuccin.homeModules.catppuccin
            inputs.zen-browser.homeModules.twilight
            # inputs.devenv.homeManagerModules.devenv
            # inputs.treefmt-nix.homeManagerModules.treefmt
          ];
        };
    in

    {
      nixosModules = {
        system = import ./modules;
        packages = import ./packages;
      };

      homeManagerModules = {
        user = import ./users/bye/home.nix;
      };

      nixosConfigurations = {
        sol = mkSystem {
          hostname = "sol";
          username = "bye";
        };
      };

      homeConfigurations = {
        "bye" = mkHome {
          hostname = "sol";
          username = "bye";
        };
      };

      devenvModules = {
        base =
          { pkgs, ... }:
          {
            packages = with pkgs; [
              jq
              k6
              curlie
              tokei
              glow
            ];
          };

        nix =
          { pkgs, ... }:
          {
            languages.nix.enable = true;
            packages = with pkgs; [
              nixd
              statix
              deadnix
            ];
            git-hooks.hooks.nixpkgs-fmt.enable = true;
          };

        go =
          { pkgs, ... }:
          {
            languages.go.enable = true;
            packages = with pkgs; [
              gopls
              golangci-lint
            ];
            git-hooks.hooks.gofmt.enable = true;
          };

        php =
          { pkgs, ... }:
          {
            languages.php.enable = true;
            packages = with pkgs; [
              phpactor
              php83Packages.php-cs-fixer
            ];
          };

        js =
          { pkgs, ... }:
          {
            languages = {
              javascript = {
                enable = true;
                package = pkgs.nodejs-slim_22;
                npm.enable = false;
                bun.enable = true;
              };
              typescript.enable = true;
            };
            packages = with pkgs; [
              nodePackages.npm
              typescript-language-server
              tailwindcss-language-server
              vscode-langservers-extracted
            ];
          };

        default =
          { ... }:
          {
            imports = with self.devenvModules; [
              base
              nix
              go
              php
              js
            ];
          };
      };

      devShells.x86_64-linux.default =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        in
        inputs.devenv.lib.mkShell {
          inherit pkgs inputs;
          modules = [
            self.devenvModules.default
            (
              { lib, ... }:
              {
                devenv.root =
                  let
                    root = ./.;
                  in
                  if lib.hasPrefix "/nix/store" (toString root) then "/tmp" else toString root;

                git-hooks.enable = true;

                enterShell = ''
                  echo "Welcome to development environment, good luck!"
                '';
              }
            )
          ];
        };
    };
}
