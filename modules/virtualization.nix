{ config, ... }:

{
  virtualisation = {
    podman.enable = false;
    libvirtd.enable = true;
  };
}
