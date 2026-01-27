{
  description = "Nix + Flake + Standalone HM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:YaLTeR/niri";
    nsticky.url = "github:lonerOrz/nsticky";
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wooz = {
      url = "github:negrel/wooz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    catppuccin.url = "github:catppuccin/nix";
    octotype.url = "github:mahlquistj/octotype/main";
    gittype.url = "github:unhappychoice/gittype";
    gophertube = {
      url = "github:KrishnaSSH/gophertube";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    trilium-notes = {
      url = "github:TriliumNext/Trilium/v0.101.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    # affinity-nix = {
    #   url = "github:mrshmllow/affinity-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
 }:
  let
    username = "bye";
    description = "Bayu Saputro";
    hashPasswd = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    hostname = "sol";
    shell = "fish";
    timezone = "Asia/Jakarta";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "id_ID.UTF-8";
    groups = [
      "networkmanager"
      "wheel"
    ];
    xkb = {
      layout = "us";
      variant = "";
    };
    git = {
      user = "benesamaritan";
      email = "243715333+benesamaritan@users.noreply.github.com";
    };
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {
        inherit
        inputs
        hostname
        username
        git
        hashPasswd
        description
        groups
        timezone
        defaultLocale
        extraLocale
        xkb
        shell;
      };
      modules = [
        ./configuration.nix
      ];
    };
    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs hostname username git; };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
