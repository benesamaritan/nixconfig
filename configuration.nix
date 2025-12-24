{ config, pkgs, username, description, hostname, groups, timezone, defaultLocale, extraLocale, xkb, shell, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/desktop.nix
      ./apps/kanata.nix
      ./apps/system-lv.nix
      # ./apps/flatpaks.nix
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

  networking.hostName = "${hostname}";
  time.timeZone = "${timezone}";
  i18n.defaultLocale = "${defaultLocale}";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.libinput.enable = true;
  security.rtkit.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  virtualisation.podman.enable = true;
  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.fish.enable = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${extraLocale}";
    LC_IDENTIFICATION = "${extraLocale}";
    LC_MEASUREMENT = "${extraLocale}";
    LC_MONETARY = "${extraLocale}";
    LC_NAME = "${extraLocale}";
    LC_NUMERIC = "${extraLocale}";
    LC_PAPER = "${extraLocale}";
    LC_TELEPHONE = "${extraLocale}";
    LC_TIME = "${extraLocale}";
  };

  # Keymap in X11
  services.xserver.xkb = {
    layout = "${xkb.layout}";
    variant = "${xkb.variant}";
  };

  environment.shells = with pkgs; [ pkgs."${shell}" ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users."${username}" = {
    isNormalUser = true;
    description = "${description}";
    extraGroups = groups;
    hashedPassword = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
    shell = pkgs."${shell}";
  };
  system.stateVersion = "25.05";
}
