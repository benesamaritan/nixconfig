{
  config,
  pkgs,
  lib,
  username,
  ...
}:

let
  dockerEnabled = config.virtualisation.docker.enable;
  podmanEnabled = config.virtualisation.podman.enable;
  libvirtdEnabled = config.virtualisation.libvirtd.enable;
in
{
  virtualisation = {
    docker = {
      enable = false;
      autoPrune.enable = true; # Cleanup unused images weekly
    };

    podman = {
      enable = false;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true; # Cleanup unused images weekly
    };

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = false;
        runAsRoot = false;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
  };

  boot.kernelModules = lib.optionals (dockerEnabled || podmanEnabled) [
    "iptable_nat"
    "tun"
  ];

  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages =
    with pkgs;
    [
      freerdp
    ]
    ++ lib.optionals (dockerEnabled || podmanEnabled) [
      winboat
      iptables
      nftables
    ]
    ++ lib.optionals dockerEnabled [
      docker-compose
      lazydocker
    ]
    ++ lib.optionals podmanEnabled [
      podman-compose
    ];

  users.users.${username}.extraGroups =
    lib.optionals dockerEnabled [ "docker" ]
    ++ lib.optionals podmanEnabled [ "podman" ]
    ++ lib.optionals libvirtdEnabled [ "libvirtd" ];
}
