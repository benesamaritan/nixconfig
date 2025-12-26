{
  description = "Nix + Flake + Standalone HM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode.url = "github:AodhanHayter/opencode-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    # niri.url = "github:YaLTeR/niri";
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dsearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    username = "bye";
    description = "Bayu Saputro";
    hashPasswd = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    hostname = "sol";
    shell = "fish";
    timezone = "Asia/Jakarta";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "id_ID.UTF-8";
    groups = [
      "networkmanager"
      "wheel"
      "podman"
      "libvirtd"
      "input" # only if using
      "uinput" # kanata.nix on configuration.nix
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
      inherit system;
      specialArgs = {
        inherit inputs hostname username hashPasswd description groups timezone defaultLocale extraLocale xkb shell;
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
