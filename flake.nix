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
    agenix,
    ...
  }:

  let
    lib = nixpkgs.lib;
    defaultVars = import ./vars/default.nix { inherit nixpkgs; };
    userVars = import ./vars/benesamaritan.nix { inherit nixpkgs; };
    vars = defaultVars // userVars;
    system = vars.system;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    hostname = vars.hostname;
    timezone = vars.timezone;
    defaultLocale = vars.defaultLocale;
    extraLocale = vars.extraLocale;
    xkb = vars.xkb;
    username = vars.username;
    description = vars.description;
    hashPasswd = vars.hashPasswd;
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
    shell = vars.shell;
    groups = vars.groups;
    git = vars.git;
  in

  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {
        inherit
        inputs
        hostname
        timezone
        defaultLocale
        extraLocale
        xkb
        username
        shell
        git
        hashPasswd
        description
        groups;
      };
      modules = [
        ./configuration.nix
        inputs.agenix.nixosModules.default
      ];
    };
    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
          inputs
          hostname
          username
          git;
        };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
