{ config, pkgs, username, description, hashPasswd, hostname, groups, timezone, defaultLocale, extraLocale, xkb, shell, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/fonts.nix
      ./modules/printing.nix
      #./modules/desktop.nix
      ./modules/wm.nix
      ./modules/catppuccin-system.nix
      ./modules/virtualization.nix
      ./apps/webdev-system.nix
      ./apps/flatpak.nix
      ./apps/kanata.nix
      ./apps/kanshi.nix
      ./apps/wlr-randr.nix
      ./apps/syncthing.nix
      ./apps/system-lv.nix
      ./apps/gaming.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 2147483642;
    };
  };

  nix = {
    settings = {
      experimental-features = [
      "nix-command"
      "flakes"
      ];
      trusted-users = [ 
        "root" 
        "${username}" 
      ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  time.timeZone = "${timezone}";

  networking = {
    #wireless.enable = false;
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
    };
    hostName = "${hostname}";
  };

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  i18n = {
    defaultLocale = "${defaultLocale}";
    extraLocaleSettings = {
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
  };

  security.rtkit.enable = true;

  services = {
    libinput.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = false;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 64;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 128;
        };
      };
    };
    xserver.xkb = {
      layout = "${xkb.layout}";
      variant = "${xkb.variant}";
    };

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
