{ config, pkgs, username, description, hashPasswd, hostname, groups, timezone, defaultLocale, extraLocale, xkb, shell, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/fonts.nix
      ./modules/desktop.nix
      # ./modules/wm.nix
      ./apps/kanata.nix
      ./apps/system-lv.nix
      # ./apps/flatpaks.nix
      ./apps/gaming.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enabling experimental features
  nix = {
    settings.experimental-features = [
      "nix-command" 
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  networking.hostName = "${hostname}";
  time.timeZone = "${timezone}";
  i18n.defaultLocale = "${defaultLocale}";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  services.printing.enable = true;
  services.libinput.enable = true;
  security.rtkit.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  virtualisation.podman.enable = true;
  virtualisation.libvirtd.enable = true;

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

  services.xserver.xkb = {
    layout = "${xkb.layout}";
    variant = "${xkb.variant}";
  };

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = false;
  };

  users.users."${username}" = {
    isNormalUser = true;
    description = "${description}";
    extraGroups = groups;
    hashedPassword = hashPasswd;
    shell = pkgs."${shell}";
  };

  system.stateVersion = "25.05";
}
