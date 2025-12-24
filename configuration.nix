{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/apps.nix
      ./modules/cinnamon.nix
      ./modules/flatpaks.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enabling experimental features
  nix = {
  package = pkgs.nix;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
};

  networking.hostName = "sol";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.libinput.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.podman.enable = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.bye = {
    isNormalUser = true;
    description = "Bayu Saputro";
    extraGroups = [ "networkmanager" "wheel" "podman" "libvirtd];
    hashedPassword = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
  };
  
  system.stateVersion = "25.05";

}
